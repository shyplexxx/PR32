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
        decimal totalSum;
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
            button3.Visible = true;
            button3.Enabled = true;

        }

        private void FillClientComboBox()
        {
            string sql = "SELECT UserID, CONCAT_WS(' ', UserSourname, UserName, UserPpatronymic) AS UserFullName FROM user;";
            string q = $@"server=127.0.0.1;user=root;password=root;database=db22;";


            using (MySqlConnection conn = new MySqlConnection(q))
            {
                try
                {
                    conn.Open();
                    using (MySqlDataAdapter ada = new MySqlDataAdapter(sql, conn))
                    {
                        DataTable dt = new DataTable();
                        ada.Fill(dt);

                        DataRow newRow = dt.NewRow();
                        newRow["UserID"] = DBNull.Value;
                        newRow["UserFullName"] = "Выбрать клиента (Режим гостя)";
                        dt.Rows.InsertAt(newRow, 0);
                        comboBox1.DataSource = dt;
                        comboBox1.ValueMember = "UserID";
                        comboBox1.DisplayMember = "UserFullName";
                        comboBox1.SelectedIndex = 0;
                    }
                 }
                catch(Exception ex)
                {
                    MessageBox.Show($"{ex.Message}");
                }
            }
        }

        private void UpdateCartGrid()
        {
            dataGridView2.DataSource = null;
            dataGridView2.DataSource = cartList;
            Summ();

            dataGridView2.Columns["ProductArticle"].HeaderText = "Артиккул";
            dataGridView2.Columns["ProductName"].HeaderText = "Наименование";
            dataGridView2.Columns["ProductDesk"].HeaderText = "Описание";
            dataGridView2.Columns["ProductCost"].HeaderText = "Цена";
            dataGridView2.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            if(cartList.Count == 0)
            {
                button3.Visible = false;
                button3.Enabled = false;
            }

           

        }
        
        private void Summ()
        {
            decimal total = 0;

            foreach (var item in cartList)
            {
                total += item.ProductCost * item.ProductCount;
            }

            label2.Text = $"Общая сумма закза - {total}";
        }

        private void PO_Load(object sender, EventArgs e)
        {
            
            LoadProducts();
            FillClientComboBox();
            label3.Text = SessionManager.CurrentUserFullName;
            button3.Enabled = false;
            button3.Visible = false;
            
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

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dataGridView2.CurrentRow == null) return;

            
            var row = dataGridView2.CurrentRow;
            string article = row.Cells["ProductArticle"].Value.ToString();

           
            CartItem itemToRemove = cartList.FirstOrDefault(item => item.ProductArticle == article);

            if (itemToRemove != null)
            {
               
                if (itemToRemove.ProductCount > 1)
                {
                    itemToRemove.ProductCount -= 1; 
                }
                else
                {
                    
                    cartList.Remove(itemToRemove);
                }

               
                key = key + 1;

                
                drop = itemToRemove.ProductCount;

                
                UpdateCartGrid();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (cartList.Count == 0)
            {
                MessageBox.Show("Корзина пуста!", "Внимание", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (comboBox1.SelectedIndex == 0 || comboBox1.SelectedValue == DBNull.Value)
            {
                MessageBox.Show("Необходимо выбрать клиента или войти под учетной записью!", "Внимание", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            
            Random rand = new Random();
            int randomCode = rand.Next(100, 1000);

            string q = $"server={server};user={user};password={password};database={db};AllowPublicKeyRetrieval=True;";

            using (MySqlConnection my = new MySqlConnection(q))
            {
                try
                {
                    my.Open();

                    
                    int nextOrderID = 1;
                    string idSql = "SELECT IFNULL(MAX(OrderID), 0) + 1 FROM `order`;";

                    using (MySqlCommand idCmd = new MySqlCommand(idSql, my))
                    {
                        object maxId = idCmd.ExecuteScalar();
                        if (maxId != null && maxId != DBNull.Value)
                        {
                            nextOrderID = Convert.ToInt32(maxId);
                        }
                    }

                    
                    string orderSql = @"INSERT INTO `order` (OrderID, OrderDateOrder, OrderDateDel, OrderDelivery, OrderClient, OrderCode, OrderStatus) 
                                VALUES (@id, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), 10, @client, @code, 1);";

                    using (MySqlCommand orderCmd = new MySqlCommand(orderSql, my))
                    {
                        orderCmd.Parameters.AddWithValue("@id", nextOrderID);
                        orderCmd.Parameters.AddWithValue("@client", comboBox1.SelectedValue);
                        orderCmd.Parameters.AddWithValue("@code", randomCode);
                        orderCmd.ExecuteNonQuery();
                    }

                    
                    foreach (var item in cartList)
                    {
                        
                        string productSql = @"INSERT INTO orderproduct (OrderProductID, OrderProductAtricle, OrderProductCount) 
                                      VALUES (@orderId, @article, @count);";

                        using (MySqlCommand productCmd = new MySqlCommand(productSql, my))
                        {
                            productCmd.Parameters.AddWithValue("@orderId", nextOrderID);
                            productCmd.Parameters.AddWithValue("@article", item.ProductArticle);
                            productCmd.Parameters.AddWithValue("@count", item.ProductCount);
                            productCmd.ExecuteNonQuery();
                        }

                        
                        string updateWhSql = @"UPDATE product 
                                       SET ProductCountWH = ProductCountWH - @count 
                                       WHERE ProductArticle = @article;";

                        using (MySqlCommand whCmd = new MySqlCommand(updateWhSql, my))
                        {
                            whCmd.Parameters.AddWithValue("@count", item.ProductCount);
                            whCmd.Parameters.AddWithValue("@article", item.ProductArticle);
                            whCmd.ExecuteNonQuery();
                        }
                    }

                    
                    MessageBox.Show($"Заказ №{nextOrderID} успешно оформлен!\nКод получения: {randomCode}\nПункт выдачи: №10",
                                    "Успех", MessageBoxButtons.OK, MessageBoxIcon.Information);

                   
                    cartList.Clear();
                    UpdateCartGrid();
                    LoadProducts(textBox2.Text.Trim()); 
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка сохранения заказа: {ex.Message}", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
