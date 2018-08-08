/*
  The Computer Language Benchmarks Game
  http://shootout.alioth.debian.org/

  contributed by Ian Martins
*/
import sys.io.*;

class RegexDna
{
  public static function main()
  {
    var fin = Sys.stdin();
    var seq = fin.readAll().toString();
    var ilen = seq.length;

    // remove newlines and comments
    var r = ~/(>.*\n)|(\n)/g;
    var seq = r.replace(seq, '');
    var clen = seq.length;

    var variants = [
      'agggtaaa|tttaccct',
      '[cgt]gggtaaa|tttaccc[acg]',
      'a[act]ggtaaa|tttacc[agt]t',
      'ag[act]gtaaa|tttac[agt]ct',
      'agg[act]taaa|ttta[agt]cct',
      'aggg[acg]aaa|ttt[cgt]ccct',
      'agggt[cgt]aa|tt[acg]accct',
      'agggta[cgt]a|t[acg]taccct',
      'agggtaa[cgt]|[acg]ttaccct',
    ];

    for( vv in variants )
      Sys.println(vv + ' ' + countMatches(vv, seq));

    var subst = [['B', '(c|g|t)'],
                ['D', '(a|g|t)'],
                ['H', '(a|c|t)'],
                ['K', '(g|t)'],
                ['M', '(a|c)'],
                ['N', '(a|c|g|t)'],
                ['R', '(a|g)'],
                ['S', '(c|g)'],
                ['V', '(a|c|g)'],
                ['W', '(a|t)'],
                ['Y', '(c|t)']];

    for( ii in subst )
      seq = new EReg(ii[0], 'g').replace(seq, ii[1]);

    Sys.println('\n' + ilen + '\n' + clen + '\n' + seq.length);
  }

  private static function countMatches(regexStr, str)
  {
    var rx = new EReg(regexStr, '');
    var count = 0;
    var strCpy = str;
    while( rx.match(strCpy) )
    {
      count++;
      strCpy = rx.matchedRight();
    }    
    return count;
  }
}