using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public interface IAccountHolder
    {
        public Account Account { get; set; }
    }
}
