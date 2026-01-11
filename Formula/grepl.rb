class Grepl < Formula
  include Language::Python::Virtualenv

  desc "Explainable code search for humans and AI"
  homepage "https://github.com/miikeyanderson/grepl"
  url "https://github.com/miikeyanderson/grepl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "104b7783d3044a0f254a8ad3790d3b6bf489bd4d98f4d30dfc778fcc2eb84f8f"
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
