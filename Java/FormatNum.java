import java.util.*;
public class FormatNum {
  public static void main(String[] args) {
    System.out.printf("%05d %.2f%n", 1, 1.3D);
    System.out.printf(Locale.JAPAN,"%1$tc (%1$tA), %2$,.2f%n",
      new Date(), 1e8D);
    System.out.printf(Locale.FRANCE,"%1$tc (%1$tA), %2$,.2f%n",
      new Date(), 1e8D);
  }
}
