# grunt-peon-add-remotes
Grunt add-remotes is a Grunt [multitask](http://gruntjs.com/creating-tasks#multi-tasks) that will automatically add the remote origins to use as deployment endpoints based on the add-remotes configuration.

## Usage

* Add all configured remotes:

    peon add-remotes

* Add only the production remote:

    peon add-remotes:production


## Configuration

```
{
    "production": {
        "alias": "production",
        "url": "git@git.gitserver.com:production/myproject.git"
    },
    "staging": {
        "alias": "staging",
        "url": "git@git.gitserver.com:staging/myproject.git"
    },
    "uat": {
        "alias": "uat",
        "url": "git@git.gitserver.com:uat/myproject.git"
    }
}

```


## Release History
 * 2013-11-06 - v0.1.0 - Initial release.