Gem::Specification.new do |spec|
  spec.name          = "hookflow"
  spec.version       = "1.0.0"
  spec.authors       = ["A.A.Abroskin", "Tekintian"]
  spec.email         = ["tekintian@gmail.com"]

  spec.summary       = "A single dependency-free binary to manage all your git hooks that works with any language in any environment, and in all common team workflows."
  spec.homepage      = "https://github.com/tekintian/hookflow"
  spec.post_install_message = "Hookflow installed! Run command in your project root directory 'hookflow install -f' to complete installation."

  spec.bindir        = "bin"
  spec.executables   << "hookflow"
  spec.require_paths = ["lib"]

  spec.files = %w(
    lib/hookflow.rb
    bin/hookflow
    libexec/.keep
  ) + Dir["libexec/**/*"]

  spec.licenses = ['MIT']
end
