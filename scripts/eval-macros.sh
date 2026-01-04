#!/usr/bin/env nix-shell
#!nix-shell -i bash -p perl gnugrep coreutils

grep -rlE '@macro ::' . | grep -v eval-macros.sh | while read -r file; do
  dir=$(dirname "$file")
  base=$(basename "$file")

  (
    cd "$dir" || exit 1

    perl -i -pe '
      BEGIN { $in_block = 0 }

      if (!$in_block && /^(\s*)# \@macro :: (.*)$/) {
        my $indent = $1;
        my $cmd = $2;
        my $macro = $_; # store the full macro text as we go

        while ($cmd =~ /\\\s*$/) {
          my $next = <>;
          last unless defined $next;
          $macro .= $next; # keep this line in the file
          $next =~ s/^\s*#\s*//;  # strip leading "#"
          $cmd =~ s/\\\s*$//;
          $cmd .= " $next";
        }

        chomp($cmd);
        my @out = `$cmd 2>&1`;

        my $out = $macro; # start with original macro block
        foreach my $line (@out) {
          chomp($line);
          $out .= "${indent}$line\n";
        }

        $_ = $out;
        $in_block = 1;
        next;
      }

      if ($in_block) {
        if (/^\s*# \@end/) {
          $in_block = 0;
        } else {
          $_ = "";  # clear generated region
        }
      }
    ' "$base"
  )

  echo "$file"
done
