#!/bin/bash

prog=$(basename $0)

ss_doit=false
ss_manifest=manifest.txt
ss_purge=true
ss_report=false
while getopts Pd:m:rx arg; do
	case $arg in
		P) ss_purge=false;;
		d) ss_workdir="${OPTARG}";;
		m) ss_manifest="${OPTARG}";;
		r) ss_report=true;;
		x) ss_doit=true;;
		*) echo 'Bad arg - exiting'; exit 42;;
	esac
done

if [[ ! -d "$ss_workdir" ]]; then
	echo "ERROR :: $prog :: cannot see $ss_workdir"
	exit 1
fi

fname=/usr/local/etc/bash.d/vault.sh
if [[ -r "$fname" ]]; then
	source $fname
fi

# -----------------------

cd $ss_workdir

if [[ ! -r "$ss_manifest" ]]; then
	echo "Cannot read $ss_manifest"
else
	# pull secrets from AWS
	grep '^credential ' manifest.txt  | while read skip1 skip2 efile region_name secret_id; do
		aws secretsmanager get-secret-value --region ${region_name} --secret-id ${secret_id} | jq -r .SecretString > ${efile}
	done

	grep -v '#' $ss_manifest | sort -u | while read etype entity filename skip4 skip5 unused; do
		if [[ ! -r "$filename" ]]; then
			echo "ERROR :: $prog :: cannot read $filename"
		else
			if [[ "$etype" == "credential" ]]; then
				if $ss_doit; then
					echo '# --------------------------------'
					vault kv put $entity @$filename
				fi
				if $ss_report; then
					echo '# --------------------------------'
					echo "# $etype $entity"
					vault kv get -format=json $entity
				fi
			elif [[ "$etype" == "policy" ]]; then
				if $ss_doit; then
					echo '# --------------------------------'
					vault policy write $entity $filename
				fi
				if $ss_report; then
					echo '# --------------------------------'
					echo "# $etype $entity"
					vault policy read $entity
				fi
			elif [[ "$etype" == "role" ]]; then
				if $ss_doit; then
					echo '# --------------------------------'
					vault write $entity @$filename
				fi
				if $ss_report; then
					echo '# --------------------------------'
					echo "# $etype $entity"
					vault read $entity -format=json | jq .data.allowed_policies
				fi
			fi
		fi
	done
fi

# -----------------------

if $ss_purge; then
	/usr/bin/shred -uz -n 3 $ss_workdir/credential.d/*.json
fi

# -----------------------

exit 0
