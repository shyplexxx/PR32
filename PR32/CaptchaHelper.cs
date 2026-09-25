using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PR32
{
    public static class CaptchaHelper
    {
        private static Random random = new Random();

        public static string GenerateText()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder result = new StringBuilder(4);
            for (int i = 0; i < 4; i++)
            {
                result.Append(chars[random.Next(chars.Length)]);
            }
            return result.ToString();
        }


        public static Bitmap GenerateImage(string text, int width, int height)
        {
            Bitmap bmp = new Bitmap(width, height);
            using (Graphics g = Graphics.FromImage(bmp))
            {
                g.Clear(Color.White);

                // 1. Добавляем графический шум (точки)
                for (int i = 0; i < 150; i++)
                {
                    int x = random.Next(width);
                    int y = random.Next(height);
                    bmp.SetPixel(x, y, Color.FromArgb(random.Next(200), random.Next(200), random.Next(200)));
                }

                // 2. Рисуем перечеркивающие линии
                using (Pen pen = new Pen(Color.Gray, 2))
                {
                    for (int i = 0; i < 3; i++)
                    {
                        g.DrawLine(pen, random.Next(width), random.Next(height), random.Next(width), random.Next(height));
                    }
                }

                // 3. Выводим символы не на одной линии и с наложением (изменение X шага)
                Font font = new Font("Arial", 20, FontStyle.Bold);
                Brush brush = Brushes.Black;

                float currentX = 10;
                for (int i = 0; i < text.Length; i++)
                {
                    // Случайное смещение по вертикали (не на одной линии)
                    float y = random.Next(5, height - 30);

                    g.DrawString(text[i].ToString(), font, brush, currentX, y);

                    // Шаг по X делаем небольшим, чтобы символы могли накладываться
                    currentX += random.Next(15, 22);
                }
            }
            return bmp;
        }

    }
}
