using PR32.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

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
            string strCmd = @"SELECT ProductID, ProductArticle, ProductName, ProductUnit, ProductCost, ProductMaxSale, ProductManufacture, ProductSypplier, ProductCategory, ProductNowSale, ProductCountWH, ProductDesk, ProductImage FROM db22.product;";
            FillDataGrid(strCmd);

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
            dataGridView1.RowTemplate.Height = 152;

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
            // Проверяем, что нажали правой кнопкой мыши и попали по реальной строке, а не по шапке
            if (e.Button == MouseButtons.Right && e.RowIndex >= 0)
            {
                // Выделяем именно ту строку, по которой кликнули
                dataGridView1.ClearSelection();
                dataGridView1.Rows[e.RowIndex].Selected = true;

                SessionManager.RegisterActivity(); // Сброс таймера бездействия
            }
        }
    }
}
