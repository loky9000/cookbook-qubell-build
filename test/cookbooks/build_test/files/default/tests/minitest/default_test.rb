require 'minitest/spec'

describe_recipe "build::default" do
  it "install java package" do
    if node["platform_family"] == 'debian'
      package("openjdk-6-jdk").must_be_installed
    elsif node["platform_family"] == 'rhel'
      package("java-1.6.0-openjdk").must_be_installed
    end
  end
  it "install maven package" do
    case node["platform_family"] 
      when 'rhel'
        assert File.exist?("/usr/share/apache-maven/bin/mvn")
      when 'debian'
        assert File.exist?("/usr/bin/mvn3")
      end 
  end
  it "install git package" do
    if node["platform_family"] == 'debian'
      if node["platform_version"] < '12.04'
        package("git-core").must_be_installed
      end
    else
      package("git").must_be_installed
    end
  end
  it "create application war package" do
    assert File.exist?("#{node['build']['package']}")
  end
end
