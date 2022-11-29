package tea.entity.csvclub.testing;
import java.util.Vector;

/**
 * 采用的数据结构
 *
 * Node{
 * Node parent;
 * Node child;
 * Node brother;
 * }
 *
 *
 *
 * 创建日期 2007-11-5
 * @author wuhua
 * <p>wuhua的博客 <a href="http://wuhua.3geye.net">http://wuhua.3geye.net</a></p>
 */
public class LinkNode  {

        String value;
        LinkNode parent;
        LinkNode child;
        LinkNode borther;

        public LinkNode(String value){
                this.value = value;
        }
        public String getValue() {
                return value;
        }
        public void addNode(LinkNode child) {
                 child.parent = this;

                 //只需要记录第一个孩子节点就可以了
                 if(this.child == null){
                         this.child = child;
                         return ;
                 }

                //拿到当前菜单的上一个菜单项
                LinkNode tmp = this.child;
                while (true) {
                    if (tmp.borther == null) {
                        tmp.borther = child;
                        break;
                    } else {
                        tmp = tmp.borther;
                    }
                }


        }

        public boolean hasChildren() {
                return true;
        }
}
