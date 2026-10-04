using MySql.Data.MySqlClient;
using PR32.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Windows.Forms;

namespace PR32
{
    public partial class PO : Form
    {
        public PO()
        {
            InitializeComponent();
        }
        DataTable cartTable = new DataTable();
        decimal totalSum = 0;
        decimal totalDiscountSum = 0;

        List<CartItem> cartList = new List<CartItem>();

        int key = 0;
        int drop;
        private void AddToCart()
        {
            if (dataGridView1.CurrentRow == null) return;
            if (dataGridView1.CurrentRow == null) return;

            var row = dataGridView1.CurrentRow;
            string article = row.Cells["ProductArticle"].Value.ToString();


            drop = 0;
            foreach(var item in cartList)
            {
                if(item.ProductArticle == article)
                {
                    drop = item.ProductCount;
                }
            }



            string sql = $@"Select ProductCountWH FROM product WHERE ProductArticle = '{article}'";

            string q = $"server={server};user={user};password={password};database={db}";
            using (MySqlConnection my  = new MySqlConnection(q))
            {
                my.Open();
                using (MySqlCommand cmd = new MySqlCommand(sql, my))
                {
                    object kk = cmd.ExecuteScalar();
                    if (kk != null && kk != DBNull.Value)
                    {
                        key = Convert.ToInt32(kk);
                        key = key - drop;
                    }
                }
                
            }
            
            
            int count = 1;
            if (!string.IsNullOrEmpty(textBox1.Text) && int.TryParse(textBox1.Text, out int parsedCount))
            {
                count = parsedCount;
            }
            

            if (count > key)
            {
                MessageBox.Show("На складе нет такого кол-ва товаров!");
                textBox2.Text = "";
                return;
            }
  
            CartItem existingItem = cartList.FirstOrDefault(item => item.ProductArticle == article);

            if (existingItem != null)
            {
                existingItem.ProductCount += count;
            }
            else
            {
                cartList.Add(new CartItem
                {
                    ProductArticle = article,
                    ProductName = row.Cells["ProductName"].Value.ToString(),
                    ProductDesk = row.Cells["ProductDesk"].Value.ToString(),
                    ProductCost = Convert.ToDecimal(row.Cells["ProductCost"].Value),
                    ProductCount = count
                });
            }
    


            UpdateCartGrid();

        }


        private void UpdateCartGrid()
        {
            dataGridView2.DataSource = null;
            dataGridView2.DataSource = cartList;

            dataGridView2.Columns["ProductArticle"].HeaderText = "Артиккул";
            dataGridView2.Columns["ProductName"].HeaderText = "Наименование";
            dataGridView2.Columns["ProductDesk"].HeaderText = "Описание";
            dataGridView2.Columns["ProductCost"].HeaderText = "Цена";
            dataGridView2.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            totalSum = 0;
            foreach (var item in cartList)
            {
                totalSum = totalSum * item.ProductCount;
            }

            label2.Text = $"Общая сумма закза - {Convert.ToString(totalSum)}";

        }

        private void PO_Load(object sender, EventArgs e)
        {
            
            LoadProducts();
        }

        string server = Settings.Default.host;
        string user = Settings.Default.uid;
        string password = Settings.Default.pwd;
        string db = Settings.Default.database;
        private void LoadProducts(string searchWord = "")
        {
            string server = Settings.Default.host;
            string user = Settings.Default.uid;
            string password = Settings.Default.pwd;
            string db = Settings.Default.database;

            string whereClause = string.IsNullOrWhiteSpace(searchWord)
        ? ""
        : $"WHERE INSTR(ProductName, '{searchWord.Replace("'", "''")}') > 0";

            string q = $"server={server};user={user};password={password};database={db}";
            using (MySqlConnection mySqlConnection = new MySqlConnection(q))
            {
                mySqlConnection.Open();
                string sql = $@"SELECT ProductArticle, ProductName, ProductDesk, ProductCost FROM db22.product {whereClause};";


                using (MySqlDataAdapter adapter = new MySqlDataAdapter(sql, mySqlConnection))
                {
                    DataTable dt = new DataTable();

                 
                    adapter.Fill(dt);

                    dataGridView1.DataSource = dt;
                }

                if(dataGridView1.Columns.Count > 0)
                {
                    dataGridView1.Columns["ProductArticle"].HeaderText = "Артиккул";
                    dataGridView1.Columns["ProductName"].HeaderText = "Наименование";
                    dataGridView1.Columns["ProductDesk"].HeaderText = "Описание";
                    dataGridView1.Columns["ProductCost"].HeaderText = "Цена";
                }


            }


        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            LoadProducts(textBox2.Text.Trim());
        }

        private void button1_Click(object sender, EventArgs e)
        {
            AddToCart();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
