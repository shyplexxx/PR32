using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using PR32.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PR32
{
    public partial class Product : Form
    {
        public Product()
        {
            InitializeComponent();
            
            if (SessionManager.IsGuest)
            {
                
            }
            else
            {
                dataGridView1.ContextMenuStrip = contextMenuProduct;
                dataGridView1.CellMouseDown += dataGridView1_CellMouseDown;
            }
            UpUser();
            dataGridView1.RowTemplate.Height = 50;

        }
       

        private void UpUser()
        {
            if (SessionManager.IsGuest)
            {
                labelUserInfo.Text = $"Гость - время - {DateTime.Now.ToString("dd.MM.yyyy")}";
            }
            else
            {
                labelUserInfo.Text = SessionManager.CurrentUserFullName; 
            }

        }
        string server = Settings.Default.host;
        string user = Settings.Default.uid;
        string password = Settings.Default.pwd;
        string db = Settings.Default.database;
        string connStr = $"server={Settings.Default.host};user={Settings.Default.uid};password={Settings.Default.pwd};database={Settings.Default.database}";
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void Product_Load(object sender, EventArgs e)
        {
            
            FillDataGrid(strCmd);
            dataGridView1.RowTemplate.Height = 50;
            comboBox1.SelectedIndex = 0;


        }


        public void FillDataGrid(string strCmd)
        {

            
            dataGridView1.Columns.Clear();
            using(MySqlConnection con = new MySqlConnection(connStr))
            {
                con.Open();
                MySqlCommand command = new MySqlCommand(strCmd, con);
                MySqlDataAdapter da = new MySqlDataAdapter(command);
                DataTable dt = new DataTable();

                da.Fill(dt);
                dataGridView1.DataSource = dt;
            }
            
            

            DataGridViewImageColumn imageColumn = new DataGridViewImageColumn();
            imageColumn.Name = "MyPhoto";
            imageColumn.ImageLayout = DataGridViewImageCellLayout.Zoom;

            dataGridView1.Columns.Add(imageColumn);
            dataGridView1.AllowUserToAddRows = false;
            dataGridView1.Columns["ProductImage"].Visible = false;


            foreach(DataGridViewRow row in dataGridView1.Rows )
            {
                string name = row.Cells["ProductImage"].Value.ToString();

                if(name == "")
                {
                    name = "picture.png";
                }
                row.Cells["MyPhoto"].Value = Image.FromFile(@"./photo/" + name);

            }
            
        }

        private void dataGridView1_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            
            if (e.Button == MouseButtons.Right && e.RowIndex >= 0)
            {
                
                dataGridView1.ClearSelection();
                dataGridView1.Rows[e.RowIndex].Selected = true;

                SessionManager.RegisterActivity(); 
            }
        }


        private void MaxOrMin(string ss)
        {
            strCmd = $"SELECT p.ProductID, p.ProductArticle, p.ProductName, p.ProductUnit, p.ProductCost, p.ProductMaxSale, p.ProductManufacture, s.SypplierName AS ProductSypplier, c.CategoryName AS ProductCategory, p.ProductNowSale, p.ProductCountWH, p.ProductDesk, p.ProductImage FROM db22.product p LEFT JOIN db22.sypplier s ON p.ProductSypplier = s.SypplierID LEFT JOIN db22.category c ON p.ProductCategory = c.CategoryID {filterCondition} {searchCondition} ORDER BY p.ProductCost {ss} LIMIT {off}, 25;";
            FillDataGrid(strCmd);
        }
        int click = 1;
        string strCmd = $"SELECT p.ProductID, p.ProductArticle, p.ProductName, p.ProductUnit, p.ProductCost, p.ProductMaxSale, p.ProductManufacture, s.SypplierName AS ProductSypplier, c.CategoryName AS ProductCategory, p.ProductNowSale, p.ProductCountWH, p.ProductDesk, p.ProductImage FROM db22.product p LEFT JOIN db22.sypplier s ON p.ProductSypplier = s.SypplierID LEFT JOIN db22.category c ON p.ProductCategory = c.CategoryID LIMIT 0, 25;";
        int off = 0;
        string sortOrder = "asc";
        private void button2_Click(object sender, EventArgs e)
        {
            if(off > 0)
            {
                off = off - 25;
                strCmd = $"SELECT p.ProductID, p.ProductArticle, p.ProductName, p.ProductUnit, p.ProductCost, p.ProductMaxSale, p.ProductManufacture, s.SypplierName AS ProductSypplier, c.CategoryName AS ProductCategory, p.ProductNowSale, p.ProductCountWH, p.ProductDesk, p.ProductImage FROM db22.product p LEFT JOIN db22.sypplier s ON p.ProductSypplier = s.SypplierID LEFT JOIN db22.category c ON p.ProductCategory = c.CategoryID {filterCondition} {searchCondition} LIMIT {off}, 25;";
                FillDataGrid(strCmd);
                MaxOrMin(sortOrder);

            }
            else
            {
                return;
            }
            click--;
            label4.Text = Convert.ToString(click);
            button1.Enabled = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            
            
                off = off + 25;
                strCmd = $"SELECT p.ProductID, p.ProductArticle, p.ProductName, p.ProductUnit, p.ProductCost, p.ProductMaxSale, p.ProductManufacture, s.SypplierName AS ProductSypplier, c.CategoryName AS ProductCategory, p.ProductNowSale, p.ProductCountWH, p.ProductDesk, p.ProductImage FROM db22.product p LEFT JOIN db22.sypplier s ON p.ProductSypplier = s.SypplierID LEFT JOIN db22.category c ON p.ProductCategory = c.CategoryID {filterCondition} {searchCondition} LIMIT {off}, 25;";
                FillDataGrid(strCmd);
                click++;
                label4.Text = Convert.ToString(click);
                MaxOrMin(sortOrder);
                if (dataGridView1.RowCount == 0)
                {
                    off = off - 25;
                    strCmd = $"SELECT p.ProductID, p.ProductArticle, p.ProductName, p.ProductUnit, p.ProductCost, p.ProductMaxSale, p.ProductManufacture, s.SypplierName AS ProductSypplier, c.CategoryName AS ProductCategory, p.ProductNowSale, p.ProductCountWH, p.ProductDesk, p.ProductImage FROM db22.product p LEFT JOIN db22.sypplier s ON p.ProductSypplier = s.SypplierID LEFT JOIN db22.category c ON p.ProductCategory = c.CategoryID {filterCondition} {searchCondition} LIMIT {off}, 25;";
                FillDataGrid(strCmd);
                    click--;
                    label4.Text = Convert.ToString(click);
                    MaxOrMin(sortOrder);
                }
            
            
            
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }
        bool key = false;
        private void button3_Click(object sender, EventArgs e)
        {
            click = 1;

            if (key == false)
            {
                click = 1;
                label4.Text = Convert.ToString(click);
                sortOrder = "asc";
                off = 0;
                 MaxOrMin(sortOrder);
                 key = true;

            }
            else
            {
                click = 1;
                label4.Text = Convert.ToString(click);
                sortOrder = "desc";
                off = 0;
                MaxOrMin(sortOrder);
                key = false;
            }
        }

        string filterCondition = "";
        string searchCondition = "";
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            off = 0; 


            if (comboBox1.SelectedIndex == 1)
                filterCondition = "WHERE p.ProductNowSale >= 0 AND p.ProductNowSale < 10";
            else if (comboBox1.SelectedIndex == 2)
                filterCondition = "WHERE p.ProductNowSale >= 10 AND p.ProductNowSale < 15";
            else if (comboBox1.SelectedIndex == 3)
                filterCondition = "WHERE p.ProductNowSale >= 15";
            else
                filterCondition = "WHERE p.ProductNowSale >= 0 AND p.ProductNowSale < 100"; 

            MaxOrMin(sortOrder);
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            off = 0;

            if (!string.IsNullOrEmpty(textBox1.Text))
            {      
                string safeText = textBox1.Text.Replace("'", "''");
                searchCondition = $" AND INSTR(p.ProductName, '{safeText}') > 0";
            }
            else
            {
                searchCondition = ""; 
            }

            MaxOrMin(sortOrder);
        }
    }
}
