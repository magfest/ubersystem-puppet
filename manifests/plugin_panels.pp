# panels-specific functionality.
# TODO: probably should move this file into its own puppet module
# TODO: need to make config handling more generic, this should work with ANY plugin, and not be panels-specific

class uber::plugin_panels (
  $git_repo = "https://github.com/magfest/panels",
  $git_branch = "master",
  $hide_schedule = true,
) {
  uber::repo { "${uber::plugins_dir}/panels":
    source   => $git_repo,
    revision => $git_branch,
    require  => File["${uber::plugins_dir}"],
  }

  file { "${uber::plugins_dir}/panels/development.ini":
    ensure  => present,
    mode    => 660,
    content => template('uber/panels-development.ini.erb'),
    require => [ Uber::Repo["${uber::plugins_dir}/panels"] ],
  }
}