# AMD uprof
* Download the `.tar.bz2` from [AMD](https://www.amd.com/pt/developer/uprof.html) into this folder
* `NIXPKGS_ALLOW_UNFREE=1 nix-build -A amd-uprof`
* If needed run `nix-store --add-fixed sha256` and `nix-hash --base32 --type sha256 --flat` as shown in the message
* The final binary is: `./result/bin/AMDuProf-bin`

## Disclaimer
* I don't plan on updating this on the future
* I have used this [derivation](https://github.com/Qubasa/nixpkgs/blob/a29b3eb0f12236ddd5be13587a561ac6f94cd799/pkgs/os-specific/linux/uprof/default.nix) as an starting point, but a lot has changed from 3.4 to 5.0