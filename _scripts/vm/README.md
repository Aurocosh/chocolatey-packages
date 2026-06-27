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

All public commands use the **`MyCh`** prefix to avoid collisions with Chocolatey-AU or other modules.

### VM control

#### `Start-MyChTestVm`

Start the test VM if it is not already running. Waits up to 10 minutes for `Running` state.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | | |

```powershell
Start-MyChTestVm
```

---

#### `Stop-MyChTestVm`

Stop the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-TurnOff` | switch | Force power-off instead of graceful shutdown |
| `-Save` | switch | Save VM state (mutually exclusive with `-TurnOff`) |

Default: graceful shutdown.

```powershell
Stop-MyChTestVm
Stop-MyChTestVm -TurnOff
```

---

#### `Connect-MyChTestVm`

Open Hyper-V Manager console (`vmconnect.exe`) for the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | | |

```powershell
Connect-MyChTestVm
```

---

#### `Restore-MyChTestVm`

Restore a Hyper-V checkpoint on the test VM.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Snapshot` | string | Checkpoint name; omit to use `$Env:au_VmSnapshot` or the latest checkpoint by `CreationTime` |

```powershell
Restore-MyChTestVm
Restore-MyChTestVm -Snapshot 'good'
```

---

### Package staging and testing

#### `Stage-MyChTestPackage`

Pack (if needed), optionally clear the Vagrant `packages/` folder, and copy a `.nupkg` for guest testing.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | `.nupkg`, `.nuspec`, or package directory; default: current directory |
| `-NoClear` | switch | Do not remove existing `.nupkg`/`.xml` in `packages/` |
| `-Vagrant` | string | Override `$Env:au_Vagrant` path |

```powershell
cd automatic\my-package
Stage-MyChTestPackage
Stage-MyChTestPackage -Nu .\my-package.1.0.0.nupkg
```

---

#### `Start-MyChTestPackageManual`

Manual test workflow: stage package → restore checkpoint → start VM → open vmconnect.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | Same as `Stage-MyChTestPackage` |
| `-NoClear` | switch | Same as `Stage-MyChTestPackage` |
| `-Snapshot` | string | Same as `Restore-MyChTestVm` |
| `-NoConnect` | switch | Skip opening vmconnect |
| `-Vagrant` | string | Same as `Stage-MyChTestPackage` |

In the guest, run `~\TestAllPackages.ps1` or `~\TestAllPackages.ps1 -UninstallAfterInstall`.

```powershell
cd automatic\my-package
Start-MyChTestPackageManual
```

---

#### `Test-MyChPackageVm`

Automated test: stage → restore checkpoint → start VM → run `TestAllPackages.ps1` in guest → restore checkpoint again.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | Same as `Stage-MyChTestPackage` |
| `-UninstallAfterInstall` | switch | Pass `-UninstallAfterInstall` to guest script |
| `-ShowOutput` | switch | Stream guest output via `vagrant powershell` (recommended on Hyper-V) |
| `-Snapshot` | string | Same as `Restore-MyChTestVm` |
| `-Vagrant` | string | Same as `Stage-MyChTestPackage` |

Returns guest exit code (`0` = pass).

```powershell
cd automatic\my-package
Test-MyChPackageVm -UninstallAfterInstall -ShowOutput
```

---

### Cleanup

#### `Clear-MyChPackageArtifacts`

Delete all `*.nupkg` files under `automatic/` and `manual/` in the repo.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-RepoRoot` | string | Repo root path; default: parent of `_scripts/` |

```powershell
Clear-MyChPackageArtifacts
```

---

#### `Start-MyChTestPackageCleanUp`

`Clear-MyChPackageArtifacts` then `Start-MyChTestPackageManual`.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Nu` | path | Same as `Start-MyChTestPackageManual` |
| `-NoClear` | switch | Same as `Start-MyChTestPackageManual` |
| `-Snapshot` | string | Same as `Start-MyChTestPackageManual` |
| `-NoConnect` | switch | Same as `Start-MyChTestPackageManual` |
| `-Vagrant` | string | Same as `Start-MyChTestPackageManual` |

Repo wrapper: `clean_up_and_test.ps1`.

```powershell
Start-MyChTestPackageCleanUp
```

---

#### `Stop-MyChTestVmCleanUp`

`Stop-MyChTestVm` then `Clear-MyChPackageArtifacts`.

| Parameter | Type | Description |
|-----------|------|-------------|
| `-TurnOff` | switch | Same as `Stop-MyChTestVm` |
| `-Save` | switch | Same as `Stop-MyChTestVm` |
| `-RepoRoot` | string | Same as `Clear-MyChPackageArtifacts` |

Repo wrapper: `clean_up.ps1` (artifacts only) combines with stop via this command.

```powershell
Stop-MyChTestVmCleanUp
Stop-MyChTestVmCleanUp -TurnOff
```

---

## Typical workflows

**Manual test**

```powershell
. .\Import-TestVmModule.ps1
cd automatic\my-package
Start-MyChTestPackageManual
# In guest: ~\TestAllPackages.ps1
Stop-MyChTestVmCleanUp
```

**Automated test**

```powershell
. .\Import-TestVmModule.ps1
cd automatic\my-package
Test-MyChPackageVm -UninstallAfterInstall -ShowOutput
```

## Related docs

- User guide: `my-package-tools/docs/user/hyper-v-test-vm-commands.md`
- Test environment setup: `my-chocolatey-test-environment/ReadMe.md`
