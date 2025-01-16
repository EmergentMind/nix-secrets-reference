<div align="center">
<h1>
<img width="100" src="docs/nixos-ascendancy.png" /> <br>
</h1>
</div>

# EmergenMind's Nix-Secrets Reference Repository

This is a stripped-down, reference version of EmergenMinds's _private_ Nix-Secrets repo intended to help you set up your own. The actual, _private_ repository is pulled into [EmergentMind's _public_ Nix-Config](https://github.com/EmergentMind/nix-config) to automate provisioning of private information, passwords, and keys across hosts. 

For details on how this is accomplished, how to approach different scenarios, and troubleshooting for some common hurdles, please see the article and accompanying YouTube video [NixOS Secrets Management](https://unmovedcentre.com/posts/secrets-management/) available on my website. Note that some of the hierarchy and usage has evolved over time and while I attempt to update the article to match, I will inevitably miss something. Please feel free to let me know if you notice a discrepancy and I will make time to revise.

## What are nix-secrets?
In brief, nix-secrets are collection of "soft" and "hard" secrets. Soft secrets are effectively evaluation-time variables that I don't want in my public nix-config, but don't need to be encrypted. An example of a soft secret is a work email for git. Hard secrets are things like tokens and passwords that need encrypting with sops-nix.

## Contents:
There are two branches in this repo, simple and complex.

### Simple
In the simple branch, "soft" secrets are structured in their entirely in the `flake.nix` file and a single `secrets.yaml` file is used for "hard" secrets.

The main contents of the "simple" branch include:

- `secrets.yaml` - this is where "hard" secrets are stored and the file is encrypted/decrypted using `sops-nix`.
  IMPORTANT: The file in this example repo is _unencrypted_ and contains dummy information intended to show the basic hierarchy used in my _actual_ encrypted file.
- `.sops.yaml` - instructs `sops-nix` which age keys to use when encrypting `secrets.yaml`.
- `flake.nix` - this is where "soft" secrets are stored. It's optional in the sense that you can make use of the sops-related files above, without this file being present.

### Complex 
In the complex branch, "soft" secrets divided amongst various files based on basic categories. This is convenient when you have a large number of "soft" secrets. Some of these files also have logic to cut down on repetitive entry for some secrets, such as network entries. The "hard" secrets are also divided here, which is not necessary but provides an example of how one might do so.

The main contents of the "complex" branch include:

- `nix/` - a directory for storing "soft" secrets in categorical files, some of which include helper functions
    - `development.nix`
    - `network.nix`
    - `personal.nix`
    - `services.nix`
    - `software.nix`
    - `work.nix`
- sops/ - a directory for storing "hard" secrets in per-category sops files.
    IMPORTANT: The files in this example repo are _unencrypted_ and contain dummy information intended to show the basic hierarchy used in my _actual_ encrypted file.
    - `hostname1.yaml`
    - `shared.yaml`
    - `work.yaml`
    - `development.yaml`
- `.sops.yaml` - instructs `sops-nix` which age keys to use when encrypting `secrets.yaml`. Note that there is increased complexity in this variant of the file so that sops knows how to handle the additional secrets `.yaml` files in `sops/`.
- `flake.nix` - in this branch, the flake automatically imports all of the files in `nix/`, along with their "soft" secrets. It also provides a shell environment for use with `.envrc` when you are in the parent directory. Technically, the latter could be added to the flake in "simple" as well for convenient when managing secrets but I've kept it out for example's sake.


## How to use:
As stated above, this is just for reference. For information on how to setup something similar, please see the article linked in the second paragraph, above.

## Requirements:

Depending on the activity required, some of the following packages will be required but this is all covered in the article. Packages like age, sops, and ssh-to-age aren't necessarily installed on the host so you may need to add them to a temporary shell to perform the required action e.g. `nix-shell -p foo bar`

- age
- git
- nix-shell
- nvim or other editor
- sops-nix
- ssh
- ssh-to-age

## Support

Sincere thanks to all of my generous supporters!

If you find what I do helpful, please consider supporting my work using one of the links under "Sponsor this project" on the right-hand column of this page.

I intentionally keep all of my content ad-free but some platforms, such as YouTube, put ads on my videos outside of my control.

## Acknowledgements

This repo would not have been possible without the assistance or community contributions from these amazing people:

- [FidgetingBits](https://github.com/fidgetingbits) - My mentor, accomplice, and wingman. Thank you.
- [Mic92](https://github.com/Mic92) and [Lassulus](https://github.com/Lassulus) - My nix-config and nix-secrets leverage many of the fantastic tools that these two people maintain, such as sops-nix, disko, and nixos-anywhere.

---

[Return to top](#emergentminds-nix-secrets-reference-repository)
