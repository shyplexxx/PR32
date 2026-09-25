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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBox1.Text = Properties.Settings.Default.host;
            textBox2.Text = Properties.Settings.Default.uid;
            textBox3.Text = Properties.Settings.Default.pwd;
            textBox4.Text = Properties.Settings.Default.database;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string host = textBox1.Text;
            string uid = textBox2.Text;
            string pwd = textBox3.Text;
            string database = textBox4.Text;

            string conn = $"host={host};user={uid};password={pwd};database={database}";
            try
            {
                using(MySqlConnection con = new MySqlConnection(conn))
                {
                    con.Open();
                    MessageBox.Show("Успешное соединение", "Уведомления", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    con.Close();
                }
            }
            catch
            {
                MessageBox.Show("Соединение не установлено", "Уведомления", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Properties.Settings.Default.host = textBox1.Text;
            Properties.Settings.Default.uid = textBox2.Text;
            Properties.Settings.Default.pwd = textBox3.Text;
            Properties.Settings.Default.database = textBox4.Text;
            Properties.Settings.Default.Save();
            MessageBox.Show("Настройки подключения обновились! Перезагруте приложение", "Уведомления", MessageBoxButtons.OK, MessageBoxIcon.Information);
            Application.Restart();


        }
    }
}
