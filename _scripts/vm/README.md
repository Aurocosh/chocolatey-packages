# TestVm module

PowerShell module for Chocolatey package testing on the Hyper-V test VM (`choco-test-vm`). VM lifecycle uses Hyper-V cmdlets; in-guest commands use Vagrant (with WinRM fallback).

## Load

From the `chocolatey-packages` repo root:

```powershell
. .\Import-TestVmModule.ps1
```

## Prerequisites

| Variable | Purpose |
|----------|---------|
| `$Env:au_Vagrant` | Path to `my-chocolatey-test-environment` (set by `init.ps1`) |
| `$Env:au_TestVmName` | Optional VM name override (default: `choco-test-vm`) |
| `$Env:au_VmSnapshot` | Optional default checkpoint name for restore commands |

Hyper-V Administrators group membership is recommended for non-elevated use.

## Layout

```
_scripts/vm/
  TestVm.psm1              # Module loader (script vars + dot-source)
  Import via repo root Import-TestVmModule.ps1
  Private/                 # Internal helpers (not exported)
  Public/                  # One file per exported command
  README.md
```

## Exported commands

All public commands use the **`Choco`** prefix to avoid collisions with Chocolatey-AU or other modules.

### VM control

#### `Start-ChocoVm`

Start the test VM if it is not already running. Waits up to 10 minutes for `Running` state.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | | |

```powershell
Start-ChocoVm
```

---

#### `Stop-ChocoVm`

Stop the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-TurnOff` | switch | Force power-off instead of graceful shutdown |
| `-Save` | switch | Save VM state (mutually exclusive with `-TurnOff`) |

Default: graceful shutdown.

```powershell
Stop-ChocoVm
Stop-ChocoVm -TurnOff
```

---

#### `Connect-ChocoVm`

Open Hyper-V Manager console (`vmconnect.exe`) for the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | | |

```powershell
Connect-ChocoVm
```

---

#### `Restore-ChocoVm`

Restore a Hyper-V checkpoint on the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Snapshot` | string | Checkpoint name; omit to use `$Env:au_VmSnapshot` or the latest checkpoint by `CreationTime` |

```powershell
Restore-ChocoVm
Restore-ChocoVm -Snapshot 'good'
```

---

### Package staging and testing

#### `Export-ChocoPackage`

Pack (if needed), optionally clear the Vagrant `packages/` folder, and copy a `.nupkg` for guest testing.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | `.nupkg`, `.nuspec`, or package directory; default: current directory |
| `-NoClear` | switch | Do not remove existing `.nupkg`/`.xml` in `packages/` before the final copy |
| `-Vagrant` | string | Override `$Env:au_Vagrant` path |

```powershell
cd automatic\my-package
Export-ChocoPackage
Export-ChocoPackage -Nu .\my-package.1.0.0.nupkg
```

---

#### `Start-ChocoManualTest`

Manual test workflow: stage package → restore checkpoint → start VM → open vmconnect.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | Same as `Export-ChocoPackage` |
| `-NoClear` | switch | Same as `Export-ChocoPackage` |
| `-Snapshot` | string | Same as `Restore-ChocoVm` |
| `-NoConnect` | switch | Skip opening vmconnect |
| `-Vagrant` | string | Same as `Export-ChocoPackage` |

In the guest, run `~\TestAllPackages.ps1` or `~\TestAllPackages.ps1 -UninstallAfterInstall`.

```powershell
cd automatic\my-package
Start-ChocoManualTest
```

---

#### `Test-ChocoPackageVm`

Automated test: stage → restore checkpoint → start VM → run `TestAllPackages.ps1` in guest → restore checkpoint again → **clear test-env `packages/` and repo `*.nupkg` artifacts** (always, pass or fail).

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | Same as `Export-ChocoPackage` |
| `-UninstallAfterInstall` | switch | Pass `-UninstallAfterInstall` to guest script |
| `-ShowOutput` | switch | Stream guest output via `vagrant powershell` (recommended on Hyper-V) |
| `-Snapshot` | string | Same as `Restore-ChocoVm` |
| `-Vagrant` | string | Same as `Export-ChocoPackage` |

Returns guest exit code (`0` = pass).

```powershell
cd automatic\my-package
Test-ChocoPackageVm -UninstallAfterInstall -ShowOutput
```

---

### Cleanup

#### `Clear-ChocoPackages`

Delete package artifacts from the repo and/or the test-environment `packages/` folder.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Type` | string | `All` (default), `Repo`, or `VM` |
| `-RepoRoot` | string | Repo root path; default: parent of `_scripts/` (used when clearing Repo) |
| `-Vagrant` | string | Override `$Env:au_Vagrant` path (used when clearing VM) |

- **Repo** — delete `*.nupkg` under `automatic/` and `manual/`
- **VM** — delete `*.nupkg` and `*.xml` in `{au_Vagrant}/packages/`
- **All** — both

```powershell
Clear-ChocoPackages
Clear-ChocoPackages -Type Repo
Clear-ChocoPackages -Type VM
```

---

#### `Stop-ChocoAll`

`Stop-ChocoVm` then `Clear-ChocoPackages -Type All`.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-TurnOff` | switch | Same as `Stop-ChocoVm` |
| `-Save` | switch | Same as `Stop-ChocoVm` |
| `-RepoRoot` | string | Same as `Clear-ChocoPackages` |
| `-Vagrant` | string | Same as `Clear-ChocoPackages` |

```powershell
Stop-ChocoAll
Stop-ChocoAll -TurnOff
```

---

## Typical workflows

**Manual test**

```powershell
. .\Import-TestVmModule.ps1
cd automatic\my-package
Start-ChocoManualTest
# In guest: ~\TestAllPackages.ps1
Stop-ChocoAll
```

**Automated test**

```powershell
. .\Import-TestVmModule.ps1
cd automatic\my-package
Test-ChocoPackageVm -UninstallAfterInstall -ShowOutput
```

## Related docs

- User guide: `my-package-tools/docs/user/hyper-v-test-vm-commands.md`
- Test environment setup: `my-chocolatey-test-environment/ReadMe.md`
