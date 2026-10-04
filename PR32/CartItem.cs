using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PR32
{
    public class CartItem
    {
        public string ProductArticle { get; set; } 
        public string ProductName { get; set; }    
        public string ProductDesk { get; set; }    
        public decimal ProductCost { get; set; }  
        public int ProductCount { get; set; }
    }
}
