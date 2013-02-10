length = 4

default["ssl_settings"]= {
  "common_name" => "self-signed-cert-jenkins",
  "cert_path" => "/etc/certificates",
  "ca_path" => "/etc/pki/demoCA",
  "serial_number" => ((0..length).map{rand(256).chr}*"").unpack("H*")[0][0,length]
}
