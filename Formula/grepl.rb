class Grepl < Formula
  include Language::Python::Virtualenv

  desc "Semantic code search CLI using ChromaDB + Ollama"
  homepage "https://github.com/miikeyanderson/grepl"
  url "https://github.com/miikeyanderson/grepl/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "ec47803842bdee09c600a9ff3c434899aa0af668a01f6c0bd44979fd207cf13d"
  license "MIT"

  depends_on "python@3.11"

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", buildpath
    bin.install_symlink libexec/"bin/grepl"
  end

  test do
    system bin/"grepl", "--help"
  end
end
