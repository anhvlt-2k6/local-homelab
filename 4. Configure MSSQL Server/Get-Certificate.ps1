$domain = "workshop.neko"

# Switch Context to LocalMachine Certificate
cd Cert:\LocalMachine\My
Get-Certificate -Template Machine -Url ldap: -DnsName $domain