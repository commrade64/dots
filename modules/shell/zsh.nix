{ config, pkgs, inputs, vars, ... }: {
  users.users.${vars.username} = {
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
  };

  home-manager.users.${vars.username} = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = false; # enabled later with 'zsh-fast-syntax-highlighting'
      enableVteIntegration = true;
      dotDir = ".config/zsh";

      history = {
        save = 10000;
        share = true;
        ignoreSpace = false;
        path = "/home/${vars.username}/.local/share/zsh/zsh_history";
      };

      completionInit = ''
        autoload -Uz compinit 
        compinit -C;
        #if [[ -n /home/${vars.username}/.config/zsh/.zcompdump(#qN.mh+24) ]]; then
        #    compinit;
        #else
        #    compinit -C;
        #fi;
      '';

      initExtraFirst = ''
        setopt nocaseglob
        setopt PROMPT_SUBST
      '';

      initExtra = ''
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # Enable vim mode
        bindkey -v
        # Fix backspace in insert mode
        bindkey "^?" backward-delete-char
        bindkey '^R' history-incremental-pattern-search-backward 
        bindkey -a '/' history-incremental-pattern-search-backward 
        bindkey "^[[A" history-beginning-search-backward
        bindkey "^[[B" history-beginning-search-forward
        bindkey -a "k" history-beginning-search-backward
        bindkey -a "j" history-beginning-search-forward
        bindkey '^F' autosuggest-accept
        export KEYTIMEOUT=1
        ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
        
        # Zsh run-help function
        autoload -Uz run-help
        (( ''${+aliases[run-help]} )) && unalias run-help
        alias help=run-help

        #eval "$(direnv hook zsh)"
      '';

      plugins = [ 
        {
          name = "fzf-tab";
          src = inputs.fzf-tab.outPath;
          file = "fzf-tab.plugin.zsh";
        }
    
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
      ];

      shellAliases = {
        ls = "ls --color=auto";
        la = "ls --all --color=auto";
        ll = "ls -l --color=auto";
        lla = "ls -la --color=auto";
        rm = "rm -irf";
        cp = "cp -irf";
        wget = "wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\"";
      };
    };
  };
}
