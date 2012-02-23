module UserAgent

  class ParsedUserAgent

    attr_reader :string

    def initialize string
      @string = string.strip
    end

    def name
      ParsedUserAgent.name_for_user_agent string
    end

    def version
      ParsedUserAgent.version_for_user_agent string
    end

    def engine
      ParsedUserAgent.engine_for_user_agent string
    end

    def engine_version
      ParsedUserAgent.engine_version_for_user_agent string
    end

    def os
      ParsedUserAgent.os_for_user_agent string
    end

    def platform
      ParsedUserAgent.platform_for_user_agent string
    end

    def device
      ParsedUserAgent.device_for_user_agent string
    end

    def to_s
      string
    end

    def inspect
      "#<ParsedUserAgent:#{name} version:#{version.inspect} engine:\"#{engine.to_s}:#{engine_version}\" os:#{os.to_s.inspect}>"
    end

    def == other
      string == other.string
    end

    def self.engine_version_for_user_agent string
      $1 if string =~ /#{engine_for_user_agent(string)}[\/ ]([\d\w\.\-]+)/i
    end

    def self.version_for_user_agent string
      case name = name_for_user_agent(string)
      when :ChromeFrame ; $1 if string =~ /chromeframe\/([\d\s\.\-]+)/i
      when :Chrome ; $1 if string =~ /chrome\/([\d\w\.\-]+)/i
      when :Safari ; $1 if string =~ /version\/([\d\w\.\-]+)/i
      when :PS3    ; $1 if string =~ /([\d\w\.\-]+)\)\s*$/i
      when :PSP    ; $1 if string =~ /([\d\w\.\-]+)\)?\s*$/i
      when :"IE Mobile"; $1 if string =~ /iemobile\/([\d\.]+)/i
      else           $1 if string =~ /#{name}[\/ ]([\d\w\.\-]+)/i
      end
    end

    def self.engine_for_user_agent string
      case string
      when /webkit/i    ; :webkit
      when /khtml/i     ; :khtml
      when /konqueror/i ; :konqueror
      when /chrome/i    ; :chrome
      when /presto/i    ; :presto
      when /gecko/i     ; :gecko
      when /msie/i      ; :msie
      else                :Unknown
      end
    end

    def self.os_for_user_agent string
      case string
      when /windows nt 6\.0/i             ; :'Windows Vista'
      when /windows nt 6\.\d+/i           ; :'Windows 7'
      when /windows nt 5\.2/i             ; :'Windows 2003'
      when /windows nt 5\.1/i             ; :'Windows XP'
      when /windows nt 5\.0/i             ; :'Windows 2000'
      when /windows phone os ([^;]+);/i   ; :"Windows Phone OS #{$1}"
      when /os x (\d+)[._](\d+)/i         ; :"OS X #{$1}.#{$2}"
      when /android ([^;]+);/i            ; :"Android #{$1}"
      when /linux/i                       ; :Linux
      when /wii/i                         ; :Wii
      when /playstation 3/i               ; :Playstation
      when /playstation portable/i        ; :Playstation
      when /ipad.*os (\d+)[._](\d+)[._](\d+)/i; :"iOS #{$1}.#{$2}.#{$3}"
      when /\(ipad.*os (\d+)[._](\d+)/i   ; :"iOS #{$1}.#{$2}"
      when /iphone.*os (\d+)[._](\d+)[._](\d+)/i; :"iOS #{$1}.#{$2}.#{$3}"
      when /\iphone.*os (\d+)[._](\d+)/i ; :"iOS #{$1}.#{$2}"
      when /webos\/([^;]+);/i             ; :"webOS #{$1}"
      when /os x/i                        ; :"OS X"
      when /cros i\d{3} ([^\)]+)\)/i      ; :"ChromeOS #{$1}"
      when /rim tablet os ([^;]+);/i      ; :"RIM Tablet OS #{$1}"
      when /blackberry(\d+)\/([^\s]+)\s/i      ; :"RIM OS #{$2}"
      when /blackberry ([^;]+);/i         ; :"RIM OS"
      else                                ; :Unknown
      end
    end

    def self.platform_for_user_agent string
      case string
      when /windows phone/i; :"Windows Phone"
      when /windows/i     ; :Windows
      when /macintosh/i   ; :Macintosh
      when /android/i     ; :Android
      when /linux/i       ; :Linux
      when /wii/i         ; :Wii
      when /playstation/i ; :Playstation
      when /ipod/i        ; :iPod
      when /ipad/i        ; :iPad
      when /iphone/i      ; :iPhone
      when /blackberry/i  ; :BlackBerry
      when /playbook/i    ; :PlayBook
      when /webos/i       ; :webOS
      when /cros/i        ; :ChromeOS
      else                  :Unknown
      end
    end

    def self.name_for_user_agent string
      case string
      when /konqueror/i            ; :Konqueror
      when /chromeframe/i          ; :ChromeFrame
      when /chrome/i               ; :Chrome
      when /mobile safari/i        ; :"Mobile Safari"
      when /safari/i               ; :Safari
      when /iemobile/i             ; :"IE Mobile"
      when /msie/i                 ; :IE
      when /opera/i                ; :Opera
      when /playstation 3/i        ; :PS3
      when /playstation portable/i ; :PSP
      when /firefox/i              ; :Firefox
      when /ipad|iphone|ipod/i     ; :"Mobile Safari"
      when /blackberry/i           ; :"BlackBerrry"
      else                         ; :Unknown
      end
    end

    def self.device_for_user_agent string
      case platform = platform_for_user_agent(string)
      when :Windows, :Macintosh, :Linux, :ChromeOS ; :Desktop
      when :iPod, :iPad, :iPhone, :BlackBerry, :PlayBook, :Android, :webOS, :"Windows Phone" ; :Mobile
      when :Wii, :Playstation ; :"Game Console"
      else ; :Unknown
      end
    end

    @agents = []

    def self.map name, options = {}
      @agents << [name, options]
    end

  end
end
