class Grepl < Formula
  include Language::Python::Virtualenv

  desc "Semantic code search CLI using ChromaDB + Ollama"
  homepage "https://github.com/miikeyanderson/grepl"
  url "https://github.com/miikeyanderson/grepl/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "e35402010b67b2189ff7801e0c5842bd537d4d768cf5b901908afd6ea7af86b8"
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
