Gem::Specification.new do |spec|
  spec.name = 'oja'
  spec.version = '0.2.0'

  spec.author = "Manfred Stienstra"
  spec.email = "manfred@fngtps.com"

  spec.description = <<-EOF
    Oja is a Ruby client for verification of Apple Store Receipts.
  EOF
  spec.summary = <<-EOF
    iOS and Mac application receive Receipts when handling purchases from the
    App Store. Before authorizing access to in-app content, these applications
    need to verify the receipt with Apple. Oja helps you check the Receipt's
    status.
  EOF

  spec.files = Dir.glob("{lib}/**/*") + %w(LICENSE README.md)

  spec.has_rdoc = true
  spec.extra_rdoc_files = ['LICENSE']
  spec.rdoc_options << "--charset=utf-8"
  spec.add_dependency('nap')
end