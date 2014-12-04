OPAM_DEPENDS="ocamlfind ounit re"

case "$OCAML_VERSION,$OPAM_VERSION" in
  3.12.1,1.2.0) ppa=avsm/ocaml312+opam12 ;;
  4.00.1,1.2.0) ppa=avsm/ocaml40+opam12 ;;
  4.01.0,1.2.0) ppa=avsm/ocaml41+opam12 ;;
  *) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam
export OPAMYES=1
opam init
opam install ${OPAM_DEPENDS}
eval `opam config env`
make
make test
