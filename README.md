# cfdnsbackup
backup script for cloudflare dns zones

You just run the script and it will make a zone file for every domain the key can access in backup.dns/
Then it will zip compress backup.dns/ into a file like 20191012.cfdns.zip for oct 12, 2019.
This is made for cloudflare tokens as opposed to the global API key like all other scripts I found use.
you need read permissions for Zone.Zone, Zone.DNS for all zones which this script should be able to back up.
