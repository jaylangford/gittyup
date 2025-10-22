{ lib
, python3
, fetchFromGitHub
, git
}:

python3.pkgs.buildPythonApplication rec {
  pname = "gittyup-cli";
  version = "1.0.1";
  pyproject = true;

  src = ./.;

  build-system = with python3.pkgs; [
    hatchling
  ];

  dependencies = with python3.pkgs; [
    colorama
    click
    diskcache
    platformdirs
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  nativeCheckInputs = with python3.pkgs; [
    pytest
    pytest-cov
  ];

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath [ git ]}"
  ];

  pythonImportsCheck = [
    "gittyup"
  ];

  meta = with lib; {
    description = "Automatically discover and update all git repositories in a directory tree";
    homepage = "https://github.com/mikeckennedy/gittyup";
    license = licenses.mit;
    mainProgram = "gittyup";
  };
}
