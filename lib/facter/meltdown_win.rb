Facter.add('meltdown') do
    confine :osfamily => :windows
    setcode do
        require 'json'
        value = nil
        sysroot = ENV['SystemRoot']
        programdata = ENV['ProgramData']
        powershell = "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
        checker_script = "C:\\ProgramData\\PuppetLabs\\puppet\\cache\\lib\\spectre-meltdown-checker.ps1"
        value = Facter::Core::Execution.execute("#{powershell} -ExecutionPolicy Unrestricted -File #{checker_script}")
        value = JSON.pretty_generate(JSON(value))
    end
    value
end