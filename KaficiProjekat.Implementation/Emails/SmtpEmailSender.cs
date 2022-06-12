using KaficiProjekat.Application.Emails;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace KaficiProjekat.Implementation.Emails
{
    public class SmtpEmailSender : IEmailSender
    {

        private readonly string email;
        private readonly string password;

        public SmtpEmailSender(string email, string password)
        {
            this.email = email;
            this.password = password;
        }

        public void Send(EmailDTO dto)
        {
            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(email,password),
                UseDefaultCredentials = false
            };
            var message = new MailMessage(email, dto.To);
            message.Subject = dto.Title;
            message.Body = dto.Body;
            message.IsBodyHtml = true;

            smtp.Send(message);
        }
    }
}
