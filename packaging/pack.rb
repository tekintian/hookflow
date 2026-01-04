#!/usr/bin/env ruby

require "fileutils"
require "digest"
require "open-uri"

VERSION = "1.0.0"

ROOT = File.join(__dir__, "..")
DIST = File.join(ROOT, "dist")

module Pack
  extend FileUtils

  module_function

  def prepare
    clean
    set_version
    put_additional_files
    put_binaries
  end

  def clean
    cd(__dir__)
    puts "Cleaning... "
    rm(Dir["npm/**/README.md"])
    rm(Dir["npm/**/hookflow*"].filter(&File.method(:file?)))
    system("git clean -fdX npm-installer/ npm-bundled/ npm-bundled/bin/ rubygems/libexec/ rubygems/pkg/ pypi pypi/hookflow/", exception: true)
    puts "done"
  end

  def set_version
    cd(__dir__)
    puts "Replacing version to #{VERSION} in packages"
    (Dir["npm/**/package.json"] + ["npm-bundled/package.json", "npm-installer/package.json"]).each do |package_json|
      replace_in_file(package_json, /"version": "[\d.]+"/, %{"version": "#{VERSION}"})
    end

    replace_in_file("npm/hookflow/package.json", /"(@tekintian\/hookflow-.+)": "[\d.]+"/, %{"\\1": "#{VERSION}"})
    replace_in_file("rubygems/hookflow.gemspec", /(spec\.version\s+= ).*/, %{\\1"#{VERSION}"})
    replace_in_file("pypi/setup.py", /(version+=).*/, %{\\1'#{VERSION}',})
    replace_in_file("aur/hookflow/PKGBUILD", /(pkgver+=).*/, %{\\1#{VERSION}})
    replace_in_file("aur/hookflow-bin/PKGBUILD", /(pkgver+=).*/, %{\\1#{VERSION}})
  end

  def put_additional_files
    cd(__dir__)
    puts "Putting README... "
    Dir["npm/*"].each do |npm_dir|
      cp(File.join(ROOT, "README.md"), File.join(npm_dir, "README.md"), verbose: true)
    end
    cp(File.join(ROOT, "README.md"), "npm-bundled/", verbose: true)
    cp(File.join(ROOT, "README.md"), "npm-installer/", verbose: true)

    puts "Putting schema.json..."
    cp(File.join(ROOT, "schema.json"), "npm/hookflow/", verbose: true)
    cp(File.join(ROOT, "schema.json"), "npm-bundled/", verbose: true)
    cp(File.join(ROOT, "schema.json"), "npm-installer/", verbose: true)
    puts "done"
  end

  def put_binaries
    cd(__dir__)
    puts "Putting binaries to packages..."
    {
      "#{DIST}/no_self_update_linux_amd64_v1/hookflow"        =>  "npm/hookflow-linux-x64/bin/hookflow",
      "#{DIST}/no_self_update_linux_arm64_v8.0/hookflow"           =>  "npm/hookflow-linux-arm64/bin/hookflow",
      "#{DIST}/no_self_update_freebsd_amd64_v1/hookflow"      =>  "npm/hookflow-freebsd-x64/bin/hookflow",
      "#{DIST}/no_self_update_freebsd_arm64_v8.0/hookflow"         =>  "npm/hookflow-freebsd-arm64/bin/hookflow",
      "#{DIST}/no_self_update_openbsd_amd64_v1/hookflow"      =>  "npm/hookflow-openbsd-x64/bin/hookflow",
      "#{DIST}/no_self_update_openbsd_arm64_v8.0/hookflow"         =>  "npm/hookflow-openbsd-arm64/bin/hookflow",
      "#{DIST}/no_self_update_windows_amd64_v1/hookflow.exe"  =>  "npm/hookflow-windows-x64/bin/hookflow.exe",
      "#{DIST}/no_self_update_windows_arm64_v8.0/hookflow.exe"     =>  "npm/hookflow-windows-arm64/bin/hookflow.exe",
      "#{DIST}/no_self_update_darwin_amd64_v1/hookflow"       =>  "npm/hookflow-darwin-x64/bin/hookflow",
      "#{DIST}/no_self_update_darwin_arm64_v8.0/hookflow"          =>  "npm/hookflow-darwin-arm64/bin/hookflow",
    }.each do |(source, dest)|
      mkdir_p(File.dirname(dest))
      cp(source, dest, verbose: true)
    end

    {
      "#{DIST}/no_self_update_linux_amd64_v1/hookflow"         =>  "npm-bundled/bin/hookflow-linux-x64/hookflow",
      "#{DIST}/no_self_update_linux_arm64_v8.0/hookflow"       =>  "npm-bundled/bin/hookflow-linux-arm64/hookflow",
      "#{DIST}/no_self_update_freebsd_amd64_v1/hookflow"       =>  "npm-bundled/bin/hookflow-freebsd-x64/hookflow",
      "#{DIST}/no_self_update_freebsd_arm64_v8.0/hookflow"     =>  "npm-bundled/bin/hookflow-freebsd-arm64/hookflow",
      "#{DIST}/no_self_update_openbsd_amd64_v1/hookflow"       =>  "npm-bundled/bin/hookflow-openbsd-x64/hookflow",
      "#{DIST}/no_self_update_openbsd_arm64_v8.0/hookflow"     =>  "npm-bundled/bin/hookflow-openbsd-arm64/hookflow",
      "#{DIST}/no_self_update_windows_amd64_v1/hookflow.exe"   =>  "npm-bundled/bin/hookflow-windows-x64/hookflow.exe",
      "#{DIST}/no_self_update_windows_arm64_v8.0/hookflow.exe" =>  "npm-bundled/bin/hookflow-windows-arm64/hookflow.exe",
      "#{DIST}/no_self_update_darwin_amd64_v1/hookflow"        =>  "npm-bundled/bin/hookflow-darwin-x64/hookflow",
      "#{DIST}/no_self_update_darwin_arm64_v8.0/hookflow"      =>  "npm-bundled/bin/hookflow-darwin-arm64/hookflow",
    }.each do |(source, dest)|
      mkdir_p(File.dirname(dest))
      cp(source, dest, verbose: true)
    end

    {
      "#{DIST}/no_self_update_linux_amd64_v1/hookflow"         =>  "rubygems/libexec/hookflow-linux-x64/hookflow",
      "#{DIST}/no_self_update_linux_arm64_v8.0/hookflow"       =>  "rubygems/libexec/hookflow-linux-arm64/hookflow",
      "#{DIST}/no_self_update_freebsd_amd64_v1/hookflow"       =>  "rubygems/libexec/hookflow-freebsd-x64/hookflow",
      "#{DIST}/no_self_update_freebsd_arm64_v8.0/hookflow"     =>  "rubygems/libexec/hookflow-freebsd-arm64/hookflow",
      "#{DIST}/no_self_update_openbsd_amd64_v1/hookflow"       =>  "rubygems/libexec/hookflow-openbsd-x64/hookflow",
      "#{DIST}/no_self_update_openbsd_arm64_v8.0/hookflow"     =>  "rubygems/libexec/hookflow-openbsd-arm64/hookflow",
      "#{DIST}/no_self_update_windows_amd64_v1/hookflow.exe"   =>  "rubygems/libexec/hookflow-windows-x64/hookflow.exe",
      "#{DIST}/no_self_update_windows_arm64_v8.0/hookflow.exe" =>  "rubygems/libexec/hookflow-windows-arm64/hookflow.exe",
      "#{DIST}/no_self_update_darwin_amd64_v1/hookflow"        =>  "rubygems/libexec/hookflow-darwin-x64/hookflow",
      "#{DIST}/no_self_update_darwin_arm64_v8.0/hookflow"      =>  "rubygems/libexec/hookflow-darwin-arm64/hookflow",
    }.each do |(source, dest)|
      mkdir_p(File.dirname(dest))
      cp(source, dest, verbose: true)
    end

    {
      "#{DIST}/no_self_update_linux_amd64_v1/hookflow"         =>  "pypi/hookflow/bin/hookflow-linux-x86_64/hookflow",
      "#{DIST}/no_self_update_linux_arm64_v8.0/hookflow"       =>  "pypi/hookflow/bin/hookflow-linux-arm64/hookflow",
      "#{DIST}/no_self_update_freebsd_amd64_v1/hookflow"       =>  "pypi/hookflow/bin/hookflow-freebsd-x86_64/hookflow",
      "#{DIST}/no_self_update_freebsd_arm64_v8.0/hookflow"     =>  "pypi/hookflow/bin/hookflow-freebsd-arm64/hookflow",
      "#{DIST}/no_self_update_openbsd_amd64_v1/hookflow"       =>  "pypi/hookflow/bin/hookflow-openbsd-x86_64/hookflow",
      "#{DIST}/no_self_update_openbsd_arm64_v8.0/hookflow"     =>  "pypi/hookflow/bin/hookflow-openbsd-arm64/hookflow",
      "#{DIST}/no_self_update_windows_amd64_v1/hookflow.exe"   =>  "pypi/hookflow/bin/hookflow-windows-x86_64/hookflow.exe",
      "#{DIST}/no_self_update_windows_arm64_v8.0/hookflow.exe" =>  "pypi/hookflow/bin/hookflow-windows-arm64/hookflow.exe",
      "#{DIST}/no_self_update_darwin_amd64_v1/hookflow"        =>  "pypi/hookflow/bin/hookflow-darwin-x86_64/hookflow",
      "#{DIST}/no_self_update_darwin_arm64_v8.0/hookflow"      =>  "pypi/hookflow/bin/hookflow-darwin-arm64/hookflow",
    }.each do |(source, dest)|
      mkdir_p(File.dirname(dest))
      cp(source, dest, verbose: true)
    end

    puts "done"
  end

  def publish
    publish_pypi
    publish_npm
    publish_gem
  end

  def publish_npm
    puts "Publishing hookflow npm..."
    cd(File.join(__dir__, "npm"))
    Dir["hookflow*"].each do |package|
      puts "publishing #{package}"
      cd(File.join(__dir__, "npm", package))
      system("npm publish --access public", exception: true)
      cd(File.join(__dir__, "npm"))
    end

    puts "Publishing @tekintian/hookflow npm..."
    cd(File.join(__dir__, "npm-bundled"))
    system("npm publish --access public", exception: true)

    puts "Publishing @tekintian/hookflow-installer npm..."
    cd(File.join(__dir__, "npm-installer"))
    system("npm publish --access public", exception: true)
  end

  def publish_gem
    puts "Publishing to Rubygems..."
    cd(File.join(__dir__, "rubygems"))
    system("rake build", exception: true)
    system("gem push pkg/*.gem", exception: true)
  end

  def publish_pypi
    puts "Publishing to PyPI..."
    cd(File.join(__dir__, "pypi"))
    system("python setup.py sdist bdist_wheel", exception: true)
    system("python -m twine upload --verbose --repository hookflow dist/*", exception: true)
  end

  def publish_aur_hookflow
    publish_aur("hookflow", {
      sha256sum: "https://github.com/tekintian/hookflow/archive/v#{VERSION}.tar.gz"
    })
  end

  def publish_aur_hookflow_bin
    publish_aur("hookflow-bin", {
      sha256sum_linux_x86_64: "https://github.com/tekintian/hookflow/releases/download/v#{VERSION}/hookflow_#{VERSION}_Linux_x86_64.gz",
      sha256sum_linux_aarch64: "https://github.com/tekintian/hookflow/releases/download/v#{VERSION}/hookflow_#{VERSION}_Linux_aarch64.gz"
    })
  end

  def publish_aur(package_name, sha256urls = {})
    aur_repo = File.join(__dir__, "#{package_name}-aur")
    system("git clone ssh://aur@aur.archlinux.org/#{package_name}.git #{aur_repo}", exception: true)
    pkgbuild_source = File.join(__dir__, "aur", package_name, "PKGBUILD")
    pkgbuild_dest = File.join(aur_repo, "PKGBUILD")
    cp(pkgbuild_source, pkgbuild_dest, verbose: true)

    sha256sums = {}
    sha256urls.each do |name, url|
      sha256 = Digest::SHA256.new
      URI.open(url) do |file|
        while chunk = file.read(1024)  # Read the file in chunks
          sha256.update(chunk)
        end
      end

      sha256sums[name] = sha256.hexdigest
    end

    sha256sums.each do |name, sha256sum|
      replace_in_file(pkgbuild_dest, /{{ #{name} }}/, sha256sum)
    end

    cd(aur_repo)
    system("makepkg --printsrcinfo > .SRCINFO", exception: true)
    system("makepkg --noconfirm", exception: true)
    system("makepkg --install --noconfirm", exception: true)

    system("git config user.name 'github-actions[bot]'", exception: true)
    system("git config user.email 'github-actions[bot]@users.noreply.github.com'", exception: true)
    system("git add PKGBUILD .SRCINFO", exception: true)
    system("git commit -m 'release v#{VERSION}'", exception: true)
    system("git push origin master", exception: true)
  end

  def replace_in_file(filepath, regexp, value)
    text = File.open(filepath, "r") do |f|
      f.read
    end
    text.gsub!(regexp, value)
    File.open(filepath, "w") do |f|
      f.write(text)
    end
  end
end

ARGV.each do |cmd|
  Pack.public_send(cmd)
end
