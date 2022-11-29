package tea.entity.csvclub.testing;
import java.util.Vector;

/***
 * 树形结构的遍历实现
 * 此乃第二中方式遍历一个树，
 * 大家对比下，看看那种方式好点
 *
 *
 * 创建日期 2007-11-7
 * @author wuhua
 * <p><b>MSN </b> gggeye@hotmail.com
 * <p><b>EMAIL</b> gooogledev@gmail.com </p>
 * <p>网站支持 <a href="http://www.3geye.net">http://www.3geye.net</a></p>
 * <p>网站论坛 <a href="http://www.3geye.net/bbs">http://www.3geye.net/bbs</a></p>
 * <p>wuhua的博客 <a href="http://wuhua.3geye.net">http://wuhua.3geye.net</a></p>
 */
public class LinkTree {

        /**
         * @param args
         */
       /* public static void main(String[] args) {
                 LinkNode link = new LinkNode("一");
                 for(int i=0; i<2; i++){
                         LinkNode l = new LinkNode(" " + i);
                         for(int j=0; j<2; j++){
                                 LinkNode l1 = new LinkNode("   " + j);
                                 l.addNode(l1);
                         }
                         link.addNode(l);

                 }
                 add(link);

                 LinkNode link1 = new LinkNode("二");
                 for(int i=0; i<2; i++){
                         LinkNode l = new LinkNode(" " + i);
                         for(int j=0; j<2; j++){
                                 LinkNode l1 = new LinkNode("   " + j);
                                 l.addNode(l1);
                         }
                         link1.addNode(l);

                 }
                 add(link1);

                 show(nodes);
        }*/

        /**
         * 展示节点内容
         * @param nodes
         */
        private static void show(Vector nodes) {
                 for(int i=0; i<nodes.size(); i++){
                         LinkNode link = (LinkNode) nodes.elementAt(i);
                         println(link.value);

                         showNode(link);
                 }
        }
        public static void showNode(LinkNode node){
                if(node == null)
                        return;
                LinkNode borther = node.child;
                 while(true){
                         if(borther == null)
                                 break;
                         println(borther.value);
                         showNode(borther);
                         borther = borther.borther;

                 }
        }
        public static  void println(String s){
                System.out.println(s);
        }

        public static Vector nodes = new Vector();

        public static  void add(LinkNode node){
                nodes.add(node);
        }

}
