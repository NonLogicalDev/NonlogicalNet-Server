# NonlogicalNet-Server
My personal server, and a foray into provisioning automation.

## Intro

I was always longing for a way to develop web in a similar way to how I develop compiled code.
In such a way that every time I hit compile, the result is the same. This nice property is called
indempontence. But configuring servers was always a pain, and required manual labor or incredibly
complicated provisioning scripts. 

So I made this little system of makefiles, ansible and python scripts that lets you easely develop
on a easily discardable and rebuildable virtual machine, that can be created and provisioned
with one single command.

The process is simple you, edit the playbook in `@Provision` folder then:

```
make wipe DEPLOY.dev
```

and, poof you have your cleanly provisioned configuration running on your local VM.

Kinda reminiscent of `rm ./a.out && g++ hello.cpp` isn't it. 

## Prerequisites

- UNIX based OS
- Python
- Ruby
- Ansible
- Vagrant

## Plans For Improvement

Once I'll have time to figure out how CoreOS works. I want to tweak this workflow so that it is possible to easely
provision docker images that can later be deployed in a fleet that is entirely self aware, with nothing hardcoded.
