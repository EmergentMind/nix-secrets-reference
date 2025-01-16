{ ... }:
{
    git = {
        work.repos = {
            "github.com" = [
                "cosanostrapizza/reponame"
            ];
            "gitlab.com" = [
                "cosanostrapizza/another-reponame"
           ];
        };
        repos = {
            "github.com" = [
                "hiroprotagonist/nix-config"
                "hiroprotagonist/nix-secrets-reference"
            ];
        };
    };
}
