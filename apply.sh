sh_c='sh -c'
if [ "$(id --name --user)" != 'root' ]
  then
  if command -v sudo
    then
    sh_c='sudo -E sh -c'
  elif command -v su
    then
    sh_c='su --command'
  else
    exit 1
  fi
fi

: ${LETS_CRT_PEM:='https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem'}
for host in "$@"
do
  crt_output=/etc/docker/certs.d/${host}/ca.crt
  $sh_c "sleep 3 && test -e $crt_output || curl --create-dirs --output $crt_output ${LETS_CRT_PEM}"
done