source 'https://supermarket.chef.io'

metadata

cookbook 'nginx', '> 2.0', '< 2.4.4'

group :integration do
  cookbook 'aws', '< 2.9.0'
  cookbook 'iptables', '~> 1.0'
  cookbook 'ohai', '~> 1.1'
  cookbook 'yum', '>= 3.0'
end
