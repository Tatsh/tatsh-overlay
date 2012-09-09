import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Set;
import java.util.SortedMap;

public class ListCharsets {
  static public void main(String args[]) throws Exception {
    SortedMap charsets = Charset.availableCharsets();
    Set names = charsets.keySet();
    for (Iterator e = names.iterator(); e.hasNext();) {
      String name = (String) e.next();
      Charset charset = (Charset) charsets.get(name);
      System.out.println(charset);
      Set aliases = charset.aliases();
      for (Iterator ee = aliases.iterator(); ee.hasNext();) {
        System.out.println(ee.next());
      }
    }
  }
}
