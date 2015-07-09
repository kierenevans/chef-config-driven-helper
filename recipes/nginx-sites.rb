include_recipe 'config-driven-helper::nginx-compat-disable-default'
include_recipe 'config-driven-helper::nginx-compat-https-map-emulation'

node["nginx"]["sites"].each do |name, site_attrs|
  definition = app_vhost name do
    site site_attrs
    server_type 'nginx'
  end

  # Different versions of Chef return definitions differently
  if definition.is_a? Chef::Recipe
    site = definition.params[:site]
  else
    site = definition
  end
  ::Chef::Mixin::DeepMerge.hash_only_merge!(node.override['nginx']['sites'][name], site)
end
