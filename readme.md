# dotfiles

a dotfiles.

## usage

```sh
curl blog.153.io/dotfiles/bootstrap.sh -o bootstrap.sh
cat bootstrap.sh # in case of shenanigans
sh bootstrap.sh
```

## for yourself

idk, fork it, have a look in the folders. each folder is a self contained thing that does some stuff:

  1. if there's an `install.sh` it gets run
  2. if there's not a `nolink` file it gets linked to `~/.foldername`
  3. if there's a `linktarget` it gets linked to `~/$(< linktarget)` instead
  
## licence

CC0.
