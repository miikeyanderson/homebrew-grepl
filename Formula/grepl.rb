class Grepl < Formula
  include Language::Python::Virtualenv

  desc "Explainable code search for humans and AI"
  homepage "https://github.com/miikeyanderson/grepl"
  url "https://github.com/miikeyanderson/grepl/archive/refs/tags/v0.2.12.tar.gz"
  sha256 "f1a0449453fb34e5dc7d48c71183695cb3663962464ea6a8d62bd93bd05bf4f8"
  license "MIT"

  depends_on "python@3.11"
  depends_on "rust" => :build

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Avoid install_name_tool failures on macOS for prebuilt orjson wheels.
    ENV["RUSTFLAGS"] = "-C link-arg=-Wl,-headerpad_max_install_names"
    system libexec/"bin/pip", "install", "--no-binary", "orjson", buildpath
    bin.install_symlink libexec/"bin/grepl"
  end

  test do
    system bin/"grepl", "--help"
  end
end
