<div align="center">
<h1>
<img width="100" src="docs/nixos-ascendancy.png" /> <br>
</h1>
</div>

# EmergenMinds Nix-Secrets Reference Repository

This is a stripped-down, reference version of EmergenMinds's _private_ Nix-Secrets repo intended to help you set up your own. The actual, _private_ repository is pulled into [EmergentMind's _public_ Nix-Config](https://github.com/EmergentMind/nix-config) to automate provisioning of private information, passwords, and keys across hosts. 

For details on how this is accomplished, how to approach different scenarios, and troubleshooting for some common hurdles, please see the article and accompanying YouTube video [NixOS Secrets Management](https://unmovedcentre.com/posts/secrets-management/) available on my website. Note that some of the hierarchy and usage has evolved over time and while I attempt to update the article to match, I will inevitably miss something. Please feel free to let me know if you notice a discrepancy and I will make time to revise.

## Contents:
The main contents of this repo include:

- `secrets.yaml` - would normally encrypted/decrypted using `sops-nix`. The secrets stored in this file include private ssh keys, user passwords, service credentials, and other keys or passwords.
  IMPORTANT: The file in this example repo is _unencrypted_ and contains dummy information intended to show the basic hierarchy used in my _actual_ encrypted file.
- `.sops.yaml` - instructs `sops-nix` which age keys to use when encrypting `secrets.yaml`.
- `flake.nix` - listed last because it is optional and contains information such as email addresses and personal domains that are private but are _not_ sensitive enough to bother putting in `secrets.yaml`

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

---

[Return to top](#secrets-management)
