# <img src="https://rawcdn.githack.com/IndrekHaav/chocolatey-packages/1b8775481d616ad436c57e0117fce5d391ad8ac0/icons/tea.png" width="48" height="48" /> [*T E A*](https://gitea.com/gitea/tea)

tea is a command line tool to interact with Gitea servers.

## Description
tea is a productivity helper for Gitea. It can be used to manage most entities on one or multiple Gitea instances and provides local helpers like `tea pull checkout`. tea makes use of context provided by the repository in `$PWD` if available, but is still usable independently of `$PWD`. Configuration is persisted in `$XDG_CONFIG_HOME/tea`.

## Usage

```
tea command [subcommand] [command options] [arguments...]
```

## Commands

 - `help`, `h`  
   Shows a list of commands or help for one command

### Entities

 - `issues`, `issue`, `i` List, create and update issues
 - `pulls`, `pull`, `pr` Manage and checkout pull requests
 - `labels`, `label` Manage issue labels
 - `milestones`, `milestone`, `ms` List and create milestones
 - `releases`, `release`, `r` Manage releases
 - `times`, `time`, `t` Operate on tracked times of a repository's issues & pulls
 - `organizations`, `organization`, `org` List, create, delete organizations
 - `repos`, `repo` Show repository details

### Helpers

 - `open`, `o` Open something of the repository in web browser
 - `notifications`, `notification`, `n` Show notifications

### Setup

 - `logins`, `login` Log in to a Gitea server
 - `logout` Log out from a Gitea server
 - `shellcompletion`, `autocomplete` Install shell completion for tea

### Options

 - `--help`, `-h` show help (default: false)
 - `--version`, `-v` print the version (default: false)

### Examples

```
tea login add                       # add a login once to get started

tea pulls                           # list open pulls for the repo in $PWD
tea pulls --repo $HOME/foo          # list open pulls for the repo in $HOME/foo
tea pulls --remote upstream         # list open pulls for the repo pointed at by
                                    # your local "upstream" git remote
# list open pulls for any gitea repo at the given login instance
tea pulls --repo gitea/tea --login gitea.com

tea milestone issues 0.7.0          # view open issues for milestone '0.7.0'
tea issue 189                       # view contents of issue 189
tea open 189                        # open web ui for issue 189
tea open milestones                 # open web ui for milestones

# send gitea desktop notifications every 5 minutes (bash + libnotify)
while :; do tea notifications --mine -o simple | xargs -i notify-send {}; sleep 300; done
```
