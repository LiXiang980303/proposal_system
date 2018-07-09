package com.proposal;

import org.junit.Test;

/**
 * Created by dynam on 2017/1/9.
 */
public class StrUtilsTest {

    public static void main(String[] args) throws Annoyance {
        try {
            try {
                throw new Sneeze();
            } catch (Annoyance a) {
                System.out.println("Caught Annoyance");
                throw a;
            }
        } catch (Sneeze s) {
            System.out.println("Caught Sneeze");
            return;
        } finally {
            System.out.println("Hello World!");
        }
    }

    @Test
    public void mathTest() {
        int i = 100;
        System.out.println(i--);
        System.out.println(i);
        i++;
        System.out.println(i);
        //--i;
        System.out.println(--i);
        System.out.println(i);
        ++i;
        System.out.println(i);
        System.out.println(i++);
    }


    @Test
    public void isNullOrEmptyTest() {
        //System.out.println(StrUtils.isNullOrEmpty("1"));;

        String s1 = "Programming";
        String s2 = new String("Programming");
        String s3 = "Program";
        String s4 = "ming";
        String s5 = "Program" + "ming";
        String s6 = s3 + s4;
        System.out.println(s1 == s2);
        System.out.println(s1 == s5);
        System.out.println(s1 == s6);
        System.out.println(s1 == s6.intern());
        System.out.println(s2 == s2.intern());
        System.out.println(s1 == s2.intern());
    }

    @Test
    public void test() {
        String s = "com.jd.".replaceAll(".", "/") + "MyClass.class";
        System.out.println(s);
    }

    private static class Sneeze extends Annoyance {
    }

    private static class Annoyance extends Throwable {
    }
}
