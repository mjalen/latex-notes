{
	description = ''Derivations for my LaTeX notes. Stolen from https://flyx.org/nix-flakes-latex/'';

	outputs = { self, nixpkgs, flake-utils }:
		with flake-utils.lib; eachSystem allSystems (system:
			let
				date = toString self.lastModified; # or "$(date -d "YYYY-MM-DD" +%s)"
				pkgs = nixpkgs.legacyPackages.${system}; 
				tex = pkgs.texlive.combine { # I should edit my packages so I can reduce to scheme-basic 
					inherit (pkgs.texlive) scheme-full latex-bin latexmk; 
				};
			in rec
			{
				packages = {
					# I like when you don't need a C compiler :)
					document = pkgs.stdenvNoCC.mkDerivation rec {
						name = "LaTeX-note";
						src = self;
						buildInputs = [ pkgs.coreutils tex ];
						phases = [ "unpackPhase" "buildPhase" "installPhase" ];
						# If you want a spefic date: do ${date -d "YYYY-MM-DD" +%s} for SOURCE_DATE_EPOCH.
						buildPhase = ''
							export PATH="${pkgs.lib.makeBinPath buildInputs}";
							mkdir -p .cache/texmf-var
							env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
								SOURCE_DATE_EPOCH=${date} \
								latexmk -interaction=nonstopmode -pdf -lualatex \
								src/document.tex
						''; 
						installPhase = ''
							mkdir -p $out
							cp document.pdf $out/
						'';
					};
				};
				defaultPackage = packages.document;
			}
		);

	inputs = 
		{
			nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable should be fine
			flake-utils.url = "github:numtide/flake-utils"; # to auto-configure systems
		};
}
