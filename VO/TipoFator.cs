﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VO
{
    public class TipoFator
    {
        public int? IDTipoFator { get; set; }
        public string Nome { get; set; }
        public DateTime DataCriacao { get; set; }
        public DateTime DataModificacao { get; set; }
        public Usuario Usuario { get; set; }
    }
}
