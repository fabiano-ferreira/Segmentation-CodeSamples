USE [Segmentacao]
GO
/****** Object:  StoredProcedure [dbo].[CalculoVariavelListar]    Script Date: 11/30/2009 17:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CalculoVariavelListar]
@IdCalculoVariavel int
as
begin
	select * from CalculoVariavel
	Where IdCalculoVariavel = isnull(@IdCalculoVariavel, IdCalculoVariavel);
End
GO
/****** Object:  StoredProcedure [dbo].[CalculoVariavelNovo]    Script Date: 11/30/2009 17:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CalculoVariavelNovo]
@IdCalculoVariavel int output,
@IdVariavel int,
@IdUsuario int
as
begin
	insert into CalculoVariavel(IdVariavel, DataCriacao, DataModificacao, IdUsuario)
	values (@IdVariavel, Getdate(), Getdate(), @IdUsuario);
	select @IdCalculoVariavel = @@Identity;
End
GO
/****** Object:  StoredProcedure [dbo].[CalculoVariavelRemover]    Script Date: 11/30/2009 17:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[CalculoVariavelRemover]
@IdCalculoVariavel int
as
begin
	delete from CalculoVariavel
	Where IdCalculoVariavel = @IdCalculoVariavel;
End
GO
/****** Object:  StoredProcedure [dbo].[CampanhaEditar]    Script Date: 11/30/2009 17:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaEditar]
(
@Nome varchar(50),
@IdUsuario int,
@IdCampanha int
)
AS
BEGIN

	Update Campanha
		Set Nome = @Nome, IdUsuario = @IdUsuario, DataModificacao = GETDATE()
		Where IdCampanha = @IdCampanha;

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaListar]    Script Date: 11/30/2009 17:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaListar]
(
@IdCampanha int
)
AS
BEGIN

	Select  IdCampanha, 
			Nome,
			DataCriacao, 
			DataModificacao,
			IdUsuario
	from Campanha
		Where (IdCampanha = @IdCampanha or @IdCampanha is null);

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaModeloListar]    Script Date: 11/30/2009 17:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaModeloListar]
(
@IdCampanha int
)
AS
BEGIN

	Select	CampanhaModelo.IdCampanha,
			CampanhaModelo.IdModelo, 
			Modelo.Nome
	From CampanhaModelo inner join Modelo
			on CampanhaModelo.IdModelo = Modelo.IdModelo
		Where (IdCampanha = @IdCampanha or @IdCampanha is null)
		Order by IdCampanha;

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaModeloNovo]    Script Date: 11/30/2009 17:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaModeloNovo]
(
@IdCampanha int,
@IdModelo int
)
AS
BEGIN

	Insert into CampanhaModelo(IdCampanha, IdModelo)
		values (@IdCampanha, @IdModelo)

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaModeloRemover]    Script Date: 11/30/2009 17:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaModeloRemover]
(
@IdCampanha int,
@IdModelo int
)
AS
BEGIN

	Delete from CampanhaModelo
		where (IdCampanha = @IdCampanha)
		and (IdModelo = @IdModelo)

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaNova]    Script Date: 11/30/2009 17:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaNova]
(
@Nome varchar(50),
@IdUsuario int,
@IdCampanha int output
)
AS
BEGIN

	Insert into Campanha(Nome, DataCriacao, DataModificacao, IdUsuario)
		values (@Nome, GETDATE(), GETDATE(), @IdUsuario);
	
	Select @IdCampanha = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaRelacaoUsuarioListar]    Script Date: 11/30/2009 17:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[CampanhaRelacaoUsuarioListar]
(
@IdCampanha int,
@IdUsuario int
)
AS
BEGIN

	Select  Campanha.IdCampanha, 
			Campanha.Nome,
			Campanha.DataCriacao, 
			Campanha.DataModificacao,
			Campanha.IdUsuario
	from Campanha
	inner join CampanhaUsuario on CampanhaUsuario.IdCampanha = Campanha.IdCampanha
		Where (Campanha.IdCampanha = @IdCampanha or @IdCampanha is null)
		and (CampanhaUsuario.IdUsuario = @IdUsuario or @IdUsuario is null);

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaRemover]    Script Date: 11/30/2009 17:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaRemover]
(
@IdCampanha int
)
AS
BEGIN

	Delete from Campanha
		Where IdCampanha = @IdCampanha;

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaSemRelacaoUsuarioListar]    Script Date: 11/30/2009 17:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaSemRelacaoUsuarioListar]
(
@IdCampanha int
)
AS
BEGIN
	select Usuario.*
	from Usuario
	where Usuario.IdUsuario
	not in(
		select IdUsuario from CampanhaUsuario where CampanhaUsuario.IdCampanha = @IdCampanha)
	ORDER BY Usuario.IdUsuario ASC
END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaUsuarioListar]    Script Date: 11/30/2009 17:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaUsuarioListar]
@IdCampanha int  
AS
BEGIN
	select	Usuario.*
			
	 FROM Usuario	inner join CampanhaUsuario 
		on	CampanhaUsuario.IdUsuario = Usuario.IdUsuario
		where CampanhaUsuario.IdCampanha = @IdCampanha
		order by Usuario.IdUsuario asc;
END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaUsuarioNovo]    Script Date: 11/30/2009 17:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaUsuarioNovo]
(
@IdCampanha int,
@IdUsuario int
)
AS
BEGIN

	Insert into CampanhaUsuario(IdCampanha, IdUsuario)
		values (@IdCampanha, @IdUsuario);

END

GO
/****** Object:  StoredProcedure [dbo].[CampanhaUsuarioRemover]    Script Date: 11/30/2009 17:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CampanhaUsuarioRemover]
(
@IdCampanha int,
@IdUsuario int
)
AS
BEGIN

	Delete from CampanhaUsuario 
		where IdCampanha = @IdCampanha
		and IdUsuario = isnull(@IdUsuario, IdUsuario);

END

GO
/****** Object:  StoredProcedure [dbo].[ClasseVariavelEditar]    Script Date: 11/30/2009 17:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClasseVariavelEditar]
(
@Nome varchar(30),
@Codigo varchar(25),
@Descricao varchar(60),
@IdUsuario int,
@IdClasseVariavel int
)
AS
BEGIN

	Update ClasseVariavel
		set Nome = @Nome, Codigo = @Codigo, Descricao = @Descricao,
			DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdClasseVariavel = @IdClasseVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[ClasseVariavelListar]    Script Date: 11/30/2009 17:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClasseVariavelListar]
(
@IdClasseVariavel int
)
AS
BEGIN

	Select * from ClasseVariavel
		where IdClasseVariavel = isnull(@IdClasseVariavel, IdClasseVariavel);

END

GO
/****** Object:  StoredProcedure [dbo].[ClasseVariavelNova]    Script Date: 11/30/2009 17:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClasseVariavelNova]
(
@Nome varchar(30),
@Codigo varchar(25),
@Descricao varchar(60),
@IdUsuario int,
@IdClasseVariavel int output
)
AS
BEGIN

	Insert into ClasseVariavel(Nome, Codigo, Descricao, DataCriacao, DataModificacao, IdUsuario)
		values(@Nome, upper(@Codigo), @Descricao, GETDATE(), GETDATE(), @IdUsuario);

	Select @IdClasseVariavel = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[ClasseVariavelRemover]    Script Date: 11/30/2009 17:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClasseVariavelRemover]
(
@IdClasseVariavel int
)
AS
BEGIN

	Delete from ClasseVariavel
		where IdClasseVariavel = @IdClasseVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[ClasseVariavelValidar]    Script Date: 11/30/2009 17:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ClasseVariavelValidar]
@Codigo varchar(25)
as
begin
	select Codigo from classevariavel
	where Codigo = upper(@Codigo);
end
GO
/****** Object:  StoredProcedure [dbo].[CriterioAderenciaListar]    Script Date: 11/30/2009 17:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioAderenciaListar]
@IdCriterioAderencia int,
@IdLinhaNegocio int
AS
BEGIN
	select CriterioAderencia.*, Criterio.Nome from CriterioAderencia
	inner join Criterio on Criterio.IdCriterio = CriterioAderencia.IdCriterio
	where IdCriterioAderencia = isnull(@IdCriterioAderencia, IdCriterioAderencia)
	and Criterio.IdLinhaNegocio = @IdLinhaNegocio
	order by IdCriterioAderencia asc;
END

GO
/****** Object:  StoredProcedure [dbo].[CriterioAderenciaNovo]    Script Date: 11/30/2009 17:00:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioAderenciaNovo]
(
@IdCriterio int,
@Valor int,
@IdCriterioAderencia int output
)
AS
BEGIN

	Insert into CriterioAderencia(IdCriterio, Valor)
		values(@IdCriterio, @Valor);

	Select @IdCriterioAderencia = @@IDENTITY;

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioAderenciaRemover]    Script Date: 11/30/2009 17:00:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioAderenciaRemover]
(
@IdCriterioAderencia int
)
AS
BEGIN

	Delete from CriterioAderencia 
		where IdCriterioAderencia = isnull(@IdCriterioAderencia, IdCriterioAderencia);

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioAderenciaSegmentoListar]    Script Date: 11/30/2009 17:00:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CriterioAderenciaSegmentoListar]
(
@IdSegmento int,
@IdProduto int,
@IdVersaoProdutoFator int
)
as
BEGIN

	Select CriterioAderencia.Valor from CriterioAderencia
		inner join ProdutoCriterioAderenciaSegmento
			on CriterioAderencia.IdCriterioAderencia = ProdutoCriterioAderenciaSegmento.IdCriterioAderencia
	Where ProdutoCriterioAderenciaSegmento.IdSegmento = @IdSegmento
		and ProdutoCriterioAderenciaSegmento.IdProduto = @IdProduto
		and ProdutoCriterioAderenciaSegmento.IdVersaoProdutoFator = @IdVersaoProdutoFator

END
GO
/****** Object:  StoredProcedure [dbo].[CriterioAderenciaValorListar]    Script Date: 11/30/2009 17:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioAderenciaValorListar]
(
@Valor int
)
AS
BEGIN

	Select * from CriterioAderencia
	inner join Criterio on CriterioAderencia.IdCriterio = Criterio.IdCriterio
		where valor = @Valor

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioEditar]    Script Date: 11/30/2009 17:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioEditar]
(
@Nome varchar(50),
@IdUsuario int,
@IdCriterio int
)
AS
BEGIN

	Update Criterio
		set Nome = @Nome, DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdCriterio = @IdCriterio;

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioFatorEditar]    Script Date: 11/30/2009 17:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioFatorEditar]
(
@IdCriterio int,
@IdFator int,
@Valor decimal(8,0)
)
AS
BEGIN
	
	Update CriterioFator 
		set Valor = @Valor
		where IdCriterio = @IdCriterio
		and IdFator = @IdFator;
	
END

GO
/****** Object:  StoredProcedure [dbo].[CriterioFatorListar]    Script Date: 11/30/2009 17:00:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioFatorListar]
(
@IdCriterio int,
@IdFator int
)
AS
BEGIN

	Select * from CriterioFator
		where IdCriterio = @IdCriterio
		and IdFator = @IdFator

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioFatorNovo]    Script Date: 11/30/2009 17:00:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioFatorNovo]
(
@IdCriterio int,
@IdFator int,
@Valor decimal(8,0)
)
AS
BEGIN

	Insert into CriterioFator(IdCriterio, IdFator, Valor)
		values (@IdCriterio, @IdFator, @Valor);

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioFatorRemover]    Script Date: 11/30/2009 17:00:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioFatorRemover]
(
@IdCriterio int,
@IdFator int
)
AS
BEGIN

	Delete from CriterioFator 
		where IdCriterio = isnull(@IdCriterio, IdCriterio)
		and IdFator = isnull(@IdFator, IdFator);

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioListar]    Script Date: 11/30/2009 17:00:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioListar]
(
@IdCriterio int,
@IdLinhaNegocio int
)
AS
BEGIN

	select Criterio.*, CriterioAderencia.IdCriterioAderencia from Criterio
		inner join CriterioAderencia on CriterioAderencia.IdCriterio = Criterio.IdCriterio
	where Criterio.IdCriterio = isnull(@IdCriterio, Criterio.IdCriterio)
	and Criterio.IdLinhaNegocio = isnull(@IdLinhaNegocio, Criterio.IdLinhaNegocio)

END


GO
/****** Object:  StoredProcedure [dbo].[CriterioNovo]    Script Date: 11/30/2009 17:00:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioNovo]
(
@Nome varchar(50),
@IdUsuario int,
@IdLinhaNegocio int,
@IdCriterio int output
)
AS
BEGIN

	Insert into Criterio(Nome ,IdLinhaNegocio ,DataCriacao, DataModificacao, IdUsuario)
		values(@Nome, @IdLinhaNegocio, GETDATE(), GETDATE(), @IdUsuario);

	Select @IdCriterio = @@IDENTITY;

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioRelacaoFatorListar]    Script Date: 11/30/2009 17:00:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioRelacaoFatorListar]
(
@IdFator int
)
AS
BEGIN

	select	Criterio.*,
			CriterioFator.Valor				 
	from Criterio
		inner join CriterioFator on CriterioFator.IdCriterio = Criterio.IdCriterio
		where CriterioFator.IdFator = @IdFator

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioRelacaoVariavelListar]    Script Date: 11/30/2009 17:00:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioRelacaoVariavelListar]
(
@IdVariavel	int,
@IdLinhaNegocio int
)
AS
BEGIN

	Select  CriterioVariavel.*,
			Criterio.Nome,
			TipoCriterioVariavel.Descricao
	 from CriterioVariavel
		inner join Criterio on CriterioVariavel.IdCriterio = Criterio.IdCriterio
		left join TipoCriterioVariavel on CriterioVariavel.IdTipoCriterioVariavel = TipoCriterioVariavel.IdTipoCriterioVariavel
	where CriterioVariavel.IdVariavel = @IdVariavel
		and Criterio.IdLinhaNegocio = @IdLinhaNegocio

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioRemover]    Script Date: 11/30/2009 17:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioRemover]
(
@IdCriterio int
)
AS
BEGIN

	Delete from Criterio
		where IdCriterio = @IdCriterio;

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioSemRelacaoFatorListar]    Script Date: 11/30/2009 17:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioSemRelacaoFatorListar]
(
@IdFator int
)
AS
BEGIN

	select Criterio.* from Criterio
		where Criterio.IdCriterio not in(
			select IdCriterio from CriterioFator where CriterioFator.IdFator = @IdFator)

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioSemRelacaoVariavelListar]    Script Date: 11/30/2009 17:00:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioSemRelacaoVariavelListar]
(
@IdVariavel int,
@IdLinhaNegocio int
)
AS
BEGIN
	Select Criterio.* from Criterio
	where Criterio.IdCriterio 
		not in(
			select IdCriterio from CriterioVariavel where CriterioVariavel.IdVariavel = @IdVariavel)
	and Criterio.IdLinhaNegocio = @IdLinhaNegocio
END



GO
/****** Object:  StoredProcedure [dbo].[CriterioVariavelEditar]    Script Date: 11/30/2009 17:00:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioVariavelEditar]
(
@IdCriterio int,
@IdVariavel int,
@Valor1 decimal(8,0),
@Valor2 decimal(8,0),
@IdTipoCriterioVariavel int
)
AS
BEGIN

	Update CriterioVariavel
		set Valor1 = @Valor1, Valor2 = @Valor2, IdTipoCriterioVariavel = @IdTipoCriterioVariavel
		where IdCriterio = @IdCriterio
		and IdVariavel = @IdVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioVariavelImportacaoListar]    Script Date: 11/30/2009 17:00:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioVariavelImportacaoListar]
(
@Nome int,
@IdVariavel int
)
AS
BEGIN
	
	select CR.IdCriterio from Criterio CR
		inner join CriterioVariavel CV on CV.IdCriterio = CR.IdCriterio
		where CR.Nome = @Nome and CV.IdVariavel = @IdVariavel

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioVariavelListar]    Script Date: 11/30/2009 17:00:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioVariavelListar]
(
@IdCriterio int,
@IdVariavel	int,
@Valor1 float,
@Valor2 float,
@IdTipoCriterioVariavel int
)
AS
BEGIN

	Select * from CriterioVariavel
		where IdCriterio = isnull(@IdCriterio, IdCriterio)
		and IdVariavel = isnull(@IdVariavel, IdVariavel)
		and Valor1 = isnull(@Valor1, Valor1)
		and Valor2 = isnull(@Valor2, Valor2)
		and IdTipoCriterioVariavel = isnull(@IdTipoCriterioVariavel, IdTipoCriterioVariavel);		

END

GO
/****** Object:  StoredProcedure [dbo].[CriterioVariavelNovo]    Script Date: 11/30/2009 17:00:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioVariavelNovo]
(
@IdCriterio int,
@IdVariavel int,
@Valor1 decimal(8,0),
@Valor2 decimal(8,0),
@IdTipoCriterioVariavel int
)
AS
BEGIN
	
	Insert into CriterioVariavel(IdCriterio, IdVariavel, Valor1, Valor2, IdTipoCriterioVariavel)
		values (@IdCriterio, @IdVariavel, @Valor1, @Valor2, @IdTipoCriterioVariavel);
	
END

GO
/****** Object:  StoredProcedure [dbo].[CriterioVariavelRemover]    Script Date: 11/30/2009 17:00:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CriterioVariavelRemover]
(
@IdCriterio int,
@IdVariavel int
)
AS
BEGIN

	Delete from CriterioVariavel 
		where IdCriterio = isnull(@IdCriterio, IdCriterio)
		and IdVariavel = @IdVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeEditar]    Script Date: 11/30/2009 17:00:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeEditar]
(
@Nome varchar(50),
@Documento varchar(50),
@Regiao varchar(50),
@IdModelo int,
@IdTipoStatusEntidade int,
@IdUsuario int,
@IdEntidade int
)
AS
BEGIN

	Update Entidade
		set	Nome = @Nome,
			Documento = @Documento, 
			Regiao =  @Regiao,
			IdModelo = @IdModelo,
			IdTipoStatusEntidade = @IdTipoStatusEntidade,
			DataModificacao = GETDATE(),
			IdUsuario = @IdUsuario
		where IdEntidade = @IdEntidade;

END
GO
/****** Object:  StoredProcedure [dbo].[EntidadeListar]    Script Date: 11/30/2009 17:00:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeListar]
(
@IdEntidade int
)
AS
BEGIN

	Select * from Entidade
		where (IdEntidade = @IdEntidade or @IdEntidade is null);

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeNova]    Script Date: 11/30/2009 17:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeNova]
(
@Nome varchar(50),
@Documento varchar(50),
@IdUsuario int,
@Regiao varchar(50),
@IdModelo int,
@IdEntidade int output
)
AS
BEGIN

	Insert into Entidade(Nome, DataCriacao, DataModificacao, IdUsuario, Documento)
		values(@Nome, GETDATE(), GETDATE(), @IdUsuario, @Documento);

	Select @IdEntidade = @@IDENTITY;

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeRemover]    Script Date: 11/30/2009 17:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeRemover]
(
@IdEntidade int
)
AS
BEGIN

	Delete from Entidade
		where IdEntidade = @IdEntidade;

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeVariavelListar]    Script Date: 11/30/2009 17:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeVariavelListar]
(
@IdEntidade int,
@IdVariavel int
)
AS
BEGIN

	Select	EntidadeVariavel.IdEntidade,
			EntidadeVariavel.IdCriterio,
			EntidadeVariavel.Valor,
			Variavel.IdVariavel,
			Variavel.IdTipoVariavel,
			TipoVariavel.Nome as NomeTipoVariavel,
			Variavel.IdClasseVariavel,
			ClasseVariavel.Nome as NomeClasseVariavel,
			Variavel.IdTipoSaida,
			TipoSaida.Nome as NomeTipoSaida,
			Variavel.Codigo,
			Variavel.Descricao,
			Variavel.Significado,
			Variavel.MetodoCientificoObtencao,
			Variavel.MetodoPraticoObtencao,
			Variavel.PerguntaSistema,
			Variavel.InteligenciaSistemicaModelo,
			Variavel.Comentario,
			Variavel.DataCriacao,
			Variavel.DataModificacao,
			Variavel.IdUsuario,
			Variavel.IdTipoDadoVariavel
	from EntidadeVariavel inner join Variavel
			on EntidadeVariavel.IdVariavel = Variavel.IdVariavel
		 inner join TipoVariavel
			on Variavel.IdTipoVariavel = TipoVariavel.IdTipoVariavel
		 inner join ClasseVariavel
			on Variavel.IdClasseVariavel = ClasseVariavel.IdClasseVariavel
		 inner join TipoSaida
			on Variavel.IdTipoSaida = TipoSaida.IdTipoSaida
		 where (EntidadeVariavel.IdEntidade = isnull(@IdEntidade, EntidadeVariavel.IdEntidade) and
				EntidadeVariavel.IdVariavel = isnull(@IdVariavel, EntidadeVariavel.IdVariavel))
		 order by EntidadeVariavel.IdEntidade, Variavel.IdVariavel asc;
		 

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeVariavelNova]    Script Date: 11/30/2009 17:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeVariavelNova]
(
@IdEntidade int,
@IdVariavel int,
@Valor int,
@IdCriterio int
)
AS
BEGIN

	Insert into EntidadeVariavel(IdVariavel, IdEntidade, Valor, IdCriterio)
		values (@IdVariavel, @IdEntidade, @Valor, @IdCriterio);

END

GO
/****** Object:  StoredProcedure [dbo].[EntidadeVariavelRemover]    Script Date: 11/30/2009 17:00:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntidadeVariavelRemover]
(
@IdEntidade int,
@IdVariavel int
)
AS
BEGIN

	Delete from EntidadeVariavel
		where IdVariavel = @IdVariavel
		and IdEntidade = @IdEntidade;

END

GO
/****** Object:  StoredProcedure [dbo].[FatorCriterioListar]    Script Date: 11/30/2009 17:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[FatorCriterioListar]
(
@IdFator int
)
As
BEGIN

	Select  CriterioFator.IdFator,
			CriterioFator.IdCriterio,
			Criterio.Nome,
			CriterioFator.Valor
	From Criterio inner join CriterioFator
			on Criterio.IdCriterio = CriterioFator.IdCriterio
		inner join Fator
			on CriterioFator.IdFator = Fator.IdFator	
		where (Fator.IdFator = @IdFator or @IdFator is null)
		Order by CriterioFator.IdFator;
END
GO
/****** Object:  StoredProcedure [dbo].[FatorEditar]    Script Date: 11/30/2009 17:00:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorEditar]
(
@IdLinhaNegocio int,
@Codigo varchar(15),
@Nome varchar(40),
@Descricao varchar(500),
@IdTipoFator int,
@Peso decimal(8,0),
@Comentario varchar(40),
@IdUsuario int,
@IdFator int
)
AS
BEGIN

	Update Fator 
		set Codigo = @Codigo, Nome = @Nome, Descricao = @Descricao, IdTipoFator = @IdTipoFator,
			Peso = @Peso, Comentario = @Comentario, DataModificacao = GETDATE(), IdUsuario = @IdUsuario,
			IdLinhaNegocio = @IdLinhaNegocio
		where IdFator = @IdFator;

END

GO
/****** Object:  StoredProcedure [dbo].[FatorFiltroListar]    Script Date: 11/30/2009 17:00:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorFiltroListar]
(
@IdFator int,
@Codigo varchar(15),
@Nome varchar(40),
@IdModelo int,
@IdLinhaNegocio int,
@IdTipoFator int
)
AS
BEGIN
	Select	Fator.IdFator, 
			Fator.Codigo, 
			Fator.Nome,
			Fator.Descricao,
			Fator.IdTipoFator,
			Fator.Peso,
			Fator.Comentario,
			Fator.DataCriacao,
			Fator.DataModificacao,
			Fator.IdUsuario,
			Fator.IdLinhaNegocio,
			ModeloFator.IdModelo
	from Fator 
	inner join ModeloFator on ModeloFator.IdFator = Fator.IdFator 
	where 
		Fator.IdFator = isnull(@IdFator, Fator.IdFator) and
		ModeloFator.IdModelo = isnull(@IdModelo, ModeloFator.IdModelo) and
		Fator.IdLinhaNegocio = isnull(@IdLinhaNegocio, Fator.IdLinhaNegocio) and
		Fator.IdTipoFator = isnull(@IdTipoFator, Fator.IdTipoFator) and
		Fator.Nome Like + '%' + @Nome + '%' and
		Fator.Codigo = isnull(@Codigo, Fator.Codigo);
END
GO
/****** Object:  StoredProcedure [dbo].[FatorListar]    Script Date: 11/30/2009 17:00:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorListar]
(
@IdFator int,
@IdModelo int,
@IdLinhaNegocio int,
@IdTipoFator int
)
AS
BEGIN

	Select	Fator.IdFator, 
			Fator.Codigo, 
			Fator.Nome,
			Fator.Descricao,
			Fator.IdTipoFator,
			Fator.Peso,
			Fator.Comentario,
			Fator.DataCriacao,
			Fator.DataModificacao,
			Fator.IdUsuario,
			Fator.IdLinhaNegocio,
			ModeloFator.IdModelo,
			RelacaoFator.IdFator as IdPai
	from Fator 
	inner join ModeloFator on
		ModeloFator.IdFator = Fator.IdFator 
	left join RelacaoFator on
		RelacaoFator.IdFilho = Fator.IdFator		
		where Fator.IdFator = isnull(@IdFator, Fator.IdFator) and
				ModeloFator.IdModelo = isnull(@IdModelo, IdModelo) and
				Fator.IdLinhaNegocio = isnull(@IdLinhaNegocio, IdLinhaNegocio) and
				Fator.IdTipoFator = isnull(@IdTipoFator, IdTipoFator);

END

GO
/****** Object:  StoredProcedure [dbo].[FatorModeloFatorListar]    Script Date: 11/30/2009 17:00:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorModeloFatorListar]
(
@IdModelo int,
@IdTipoFator int
)
AS
BEGIN

	Select Fator.* from Fator
		inner join ModeloFator on Fator.IdFator = ModeloFator.IdFator
	Where Fator.IdTipoFator = @IdTipoFator
	and ModeloFator.IdModelo = @IdModelo
	
END

GO
/****** Object:  StoredProcedure [dbo].[FatorNivelSuperiorListar]    Script Date: 11/30/2009 17:00:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[FatorNivelSuperiorListar]
(
@IdFator int,
@IdFatorNivelSuperior int output
)
As
BEGIN

	if exists(Select IdFator
		from RelacaoFator
		where IdFilho = @IdFator)
	begin
		Select @IdFatorNivelSuperior = 1
	end
	else
	begin
		Select @IdFatorNivelSuperior = 0
	end

END
GO
/****** Object:  StoredProcedure [dbo].[FatorNovo]    Script Date: 11/30/2009 17:00:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorNovo]
(
@IdLinhaNegocio int,
@Codigo varchar(15),
@Nome varchar(40),
@Descricao varchar(500),
@IdTipoFator int,
@Peso decimal(8,0),
@Comentario varchar(40),
@IdUsuario int,
@IdFator int output
)
AS
BEGIN

	Insert into Fator(Codigo, Nome, Descricao, IdTipoFator, Peso, Comentario, DataCriacao,
					  DataModificacao, IdUsuario, IdLinhaNegocio)
		values(@Codigo, @Nome, @Descricao, @IdTipoFator, @Peso, @Comentario, GETDATE(),
					  GETDATE(), @IdUsuario, @IdLinhaNegocio);
	
	Select @IdFator = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[FatorPosicionamentoSemProdutoListar]    Script Date: 11/30/2009 17:00:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorPosicionamentoSemProdutoListar]
(
@IdVersaoProdutoFator int,
@IdModelo int,
@IdTipoFator int
)
AS
BEGIN

	select Fator.* from Fator
		inner join ModeloFator on Fator.IdFator = ModeloFator.IdFator 
		where Fator.IdFator not in(
            select VersaoFatorProdutoFator.IdFator from VersaoFatorProdutoFator where VersaoFatorProdutoFator.IdVersaoProdutoFator = @IdVersaoProdutoFator)
		and Fator.IdTipoFator = @IdTipoFator
		and ModeloFator.IdModelo = @IdModelo


END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoListar]    Script Date: 11/30/2009 17:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[FatorProdutoListar]
@IdProduto int
AS
BEGIN
	select * from FatorProduto
	where (IdProduto = isnull(@IdProduto, IdProduto))
END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoNivelListar]    Script Date: 11/30/2009 17:00:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorProdutoNivelListar]
@IdProdutoNivel int
AS
BEGIN
	select * from FatorProdutoNivel
	where (IdProdutoNivel = isnull(@IdProdutoNivel, IdProdutoNivel))
END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoNivelNovo]    Script Date: 11/30/2009 17:00:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorProdutoNivelNovo]
@IdFator int,
@IdProdutoNivel int
AS
BEGIN
	insert into FatorProdutoNivel(IdFator, IdProdutoNivel)
	values (@IdFator, @IdProdutoNivel)
END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoNivelRemover]    Script Date: 11/30/2009 17:00:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorProdutoNivelRemover]
@IdFator int,
@IdProdutoNivel int
AS
BEGIN
	delete from FatorProdutoNivel
	where (IdFator = isnull(@IdFator, IdFator) and IdProdutoNivel = isnull(@IdProdutoNivel, IdProdutoNivel))
END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoNovo]    Script Date: 11/30/2009 17:01:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[FatorProdutoNovo]
@IdFator int,
@IdProduto int
AS
BEGIN
	insert into FatorProduto(IdFator, IdProduto)
	values (@IdFator, @IdProduto)
END

GO
/****** Object:  StoredProcedure [dbo].[FatorProdutoRemover]    Script Date: 11/30/2009 17:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[FatorProdutoRemover]
@IdFator int,
@IdProduto int
AS
BEGIN
	delete from FatorProduto
	where (IdFator = isnull(@IdFator, IdFator) and IdProduto = isnull(@IdProduto, IdProduto))
END

GO
/****** Object:  StoredProcedure [dbo].[FatorRemover]    Script Date: 11/30/2009 17:01:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorRemover]
(
@IdFator int
)
AS
BEGIN

	Delete from Fator
		where IdFator = @IdFator;

END

GO
/****** Object:  StoredProcedure [dbo].[FatorSegmentoListar]    Script Date: 11/30/2009 17:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorSegmentoListar] 
	@IdSegmento int
AS
BEGIN	
	SELECT Fator.* , SegmentoFator.IdCriterio
	from Fator
	inner join SegmentoFator on Fator.IdFator = SegmentoFator.IdFator
	where SegmentoFator.IdSegmento = @IdSegmento
END

GO
/****** Object:  StoredProcedure [dbo].[FatorSubListar]    Script Date: 11/30/2009 17:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FatorSubListar]
(
@IdFator int
)
AS
BEGIN

	Select	IdFator,
			IdFilho
	From RelacaoFator
		where(IdFator = @IdFator or @IdFator is null)
		Order by IdFator, IdFilho;
END

GO
/****** Object:  StoredProcedure [dbo].[GraficoEditar]    Script Date: 11/30/2009 17:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GraficoEditar]
(
@Titulo varchar(40),
@IdUsuario int,
@IdGrafico int
)
AS
BEGIN

	Update Grafico
		set Titulo = @Titulo, DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdGrafico = @IdGrafico;

END

GO
/****** Object:  StoredProcedure [dbo].[GraficoListar]    Script Date: 11/30/2009 17:01:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GraficoListar]
(
@IdGrafico int
)
AS
BEGIN

	Select Grafico.*, Modelo.Nome as Model from Grafico
inner join Modelo
on
	Grafico.IDModelo = Modelo.IDModelo
		where (IdGrafico = @IdGrafico or @IdGrafico is null);

END
GO
/****** Object:  StoredProcedure [dbo].[GraficoNovo]    Script Date: 11/30/2009 17:01:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GraficoNovo]
(
@Titulo varchar(40),
@IdUsuario int,
@IdModelo int,
@IdGrafico int output
)
AS
BEGIN

	Insert into Grafico(Titulo, DataCriacao, DataModificacao, IdUsuario, IdModelo)
		values(@Titulo, GETDATE(), GETDATE(), @IdUsuario,@IdModelo);

	Select @IdGrafico = @@Identity;

END
GO
/****** Object:  StoredProcedure [dbo].[GraficoQuadranteListar]    Script Date: 11/30/2009 17:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GraficoQuadranteListar]
(
@IdGrafico int
)
AS
BEGIN

	Select * from Quadrante 
		where (IdGrafico = @IdGrafico or @IdGrafico is null);

END

GO
/****** Object:  StoredProcedure [dbo].[GraficoRemover]    Script Date: 11/30/2009 17:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GraficoRemover]
(
@IdGrafico int
)
AS
BEGIN

	Delete from Grafico
		where IdGrafico = @IdGrafico;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioClasseVariavelListar]    Script Date: 11/30/2009 17:01:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioClasseVariavelListar]
(
@IdLinhaNegocio int
)
AS
BEGIN

	Select	LinhaNegocioClasseVariavel.IdLinhaNegocio,
			LinhaNegocioClasseVariavel.IdClasseVariavel,
			ClasseVariavel.Nome,
			ClasseVariavel.Codigo,
			ClasseVariavel.Descricao,
			ClasseVariavel.DataCriacao,
			ClasseVariavel.DataModificacao,
			ClasseVariavel.IdUsuario
	from ClasseVariavel inner join LinhaNegocioClasseVariavel
			on ClasseVariavel.IdClasseVariavel = LinhaNegocioClasseVariavel.IdClasseVariavel
	where (LinhaNegocioClasseVariavel.IdLinhaNegocio = @IdLinhaNegocio or @IdLinhaNegocio is null)
	order by LinhaNegocioClasseVariavel.IdLinhaNegocio, LinhaNegocioClasseVariavel.IdClasseVariavel asc;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioClasseVariavelNova]    Script Date: 11/30/2009 17:01:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioClasseVariavelNova]
(
@IdLinhaNegocio int,
@IdClasseVariavel int
)
AS
BEGIN

	Insert into LinhaNegocioClasseVariavel(IdLinhaNegocio, IdClasseVariavel)
		values(@IdLinhaNegocio, @IdClasseVariavel);

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioClasseVariavelRemover]    Script Date: 11/30/2009 17:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioClasseVariavelRemover]
(
@IdLinhaNegocio int,
@IdClasseVariavel int
)
AS
BEGIN

	Delete from LinhaNegocioClasseVariavel      
		where IdLinhaNegocio = @IdLinhaNegocio
		and IdClasseVariavel = @IdClasseVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioEditar]    Script Date: 11/30/2009 17:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioEditar]
(
@Nome varchar(60),
@Codigo varchar(25),
@RazaoSocial varchar(60),
@CNPJ varchar(15),
@IdUsuario int,
@IdLinhaNegocio int
)
AS
BEGIN

	Update LinhaNegocio 
		set Nome = @Nome, RazaoSocial = @RazaoSocial, CNPJ = @CNPJ, DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdLinhaNegocio = @IdLinhaNegocio;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioListar]    Script Date: 11/30/2009 17:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioListar]
(
@IdLinhaNegocio int
)
AS
BEGIN

	Select * from LinhaNegocio 
		where (LinhaNegocio.IdLinhaNegocio = @IdLinhaNegocio or @IdLinhaNegocio is null);

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioNova]    Script Date: 11/30/2009 17:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioNova]
(
@Nome varchar(60),
@RazaoSocial varchar(60),
@CNPJ varchar(15),
@IdUsuario int,
@IdLinhaNegocio int output
)
AS
BEGIN

	Insert into LinhaNegocio(Nome, RazaoSocial, CNPJ, DataCriacao, DataModificacao, IdUsuario)
		values(@Nome, @RazaoSocial, @CNPJ, GETDATE(), GETDATE(), @IdUsuario);

	Select @IdLinhaNegocio = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioProdutoNivelListar]    Script Date: 11/30/2009 17:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioProdutoNivelListar]
(
@IdLinhaNegocio int
)
AS
BEGIN

	Select	LinhaNegocioProdutoNivel.IdLinhaNegocio,
			LinhaNegocioProdutoNivel.IdProdutoNivel,
			Pai.Nome as ProdutoNivelPai,
			RelacaoProdutoNivel.IdFilho,
			Filho.Nome as ProdutoNivelFilho,
			RelacaoProdutoNivelProduto.IdProduto,
			Produto.Nome as Produto
	from RelacaoProdutoNivel inner join ProdutoNivel as Pai
			on RelacaoProdutoNivel.IdProdutoNivel = Pai.IdProdutoNivel
		 inner join ProdutoNivel as Filho
			on RelacaoProdutoNivel.IdFilho = Filho.IdProdutoNivel
		 inner join LinhaNegocioProdutoNivel
			on LinhaNegocioProdutoNivel.IdProdutoNivel = Pai.IdProdutoNivel
		 left join RelacaoProdutoNivelProduto 
			on RelacaoProdutoNivelProduto.IdRelacaoNivelProduto = RelacaoProdutoNivel.IdRelacaoProdutoNivel
		 left join Produto
			on Produto.IdProduto = RelacaoProdutoNivelProduto.IdProduto
		where(LinhaNegocioProdutoNivel.IdLinhaNegocio = @IdLinhaNegocio or @IdLinhaNegocio is null)
		
		order by LinhaNegocioProdutoNivel.IdProdutoNivel, 
				 RelacaoProdutoNivel.IdFilho, RelacaoProdutoNivelProduto.IdProduto asc;
END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioProdutoNivelNovo]    Script Date: 11/30/2009 17:01:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioProdutoNivelNovo]
(
@IdLinhaNegocio int,
@IdProdutoNivel int
)
AS
BEGIN

	Insert into LinhaNegocioProdutoNivel(IdLinhaNegocio, IdProdutoNivel)
		values(@IdLinhaNegocio, @IdProdutoNivel);

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioProdutoNivelRemover]    Script Date: 11/30/2009 17:01:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioProdutoNivelRemover]
(
@IdLinhaNegocio int,
@IdProdutoNivel int
)
AS
BEGIN

	Delete from LinhaNegocioProdutoNivel     
		where IdLinhaNegocio = isnull(@IdLinhaNegocio, IdLinhaNegocio)
		and IdProdutoNivel = @IdProdutoNivel;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioRemover]    Script Date: 11/30/2009 17:01:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioRemover]
(
@IdLinhaNegocio int
)
AS
BEGIN

	Delete from LinhaNegocio      
		where IdLinhaNegocio = @IdLinhaNegocio;

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioUsuarioListar]    Script Date: 11/30/2009 17:01:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioUsuarioListar]
(
@IdLinhaNegocio int
)
AS
BEGIN

	Select	LinhaNegocioUsuario.IdLinhaNegocio,
			LinhaNegocioUsuario.IdUsuario,
			Usuario.Nome,
			Usuario.Senha,
			Usuario.MudarSenha,
			Usuario.Email,
			Usuario.DataCriacao,
			Usuario.DataModificacao,
			Usuario.LogUsuario
	from LinhaNegocioUsuario inner join Usuario
			on LinhaNegocioUsuario.IdUsuario = Usuario.IdUsuario
		 where (LinhaNegocioUsuario.IdLinhaNegocio = @IdLinhaNegocio or @IdLinhaNegocio is null);
END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioUsuarioNovo]    Script Date: 11/30/2009 17:01:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioUsuarioNovo]
(
@IdLinhaNegocio int,
@IdUsuario int
)
AS
BEGIN

	Insert into LinhaNegocioUsuario(IdLinhaNegocio, IdUsuario)
		values(@IdLinhaNegocio, @IdUsuario);

END

GO
/****** Object:  StoredProcedure [dbo].[LinhaNegocioUsuarioRemover]    Script Date: 11/30/2009 17:01:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LinhaNegocioUsuarioRemover]
(
@IdLinhaNegocio int,
@IdUsuario int
)
AS
BEGIN

	Delete from LinhaNegocioUsuario 
		where IdLinhaNegocio = isnull(@IdLinhaNegocio, IdLinhaNegocio)
		and IdUsuario = @IdUsuario;

END

GO
/****** Object:  StoredProcedure [dbo].[LogImportacaoEntidadeListar]    Script Date: 11/30/2009 17:01:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogImportacaoEntidadeListar]
(
@IdLogImportacaoEntidade int,
@Data datetime
)
AS
BEGIN

	Select * from LogImportacaoEntidade
		where (IdLogImportacaoEntidade = @IdLogImportacaoEntidade or @IdLogImportacaoEntidade is null)
		or (convert( char(10), Data, 103)  = convert( char(10), @Data, 103) or @Data is null);
		

END

GO
/****** Object:  StoredProcedure [dbo].[LogImportacaoEntidadeNovo]    Script Date: 11/30/2009 17:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogImportacaoEntidadeNovo]
(
@CodigoVariavel varchar(25),
@DocumentoEntidade varchar(25),
@IdCriterio int,
@Mensagem varchar(256),
@IdUsuario int,
@NomeUsuario varchar(20)
)
AS
BEGIN

	Insert into LogImportacaoEntidade(CodigoVariavel, DocumentoEntidade,
									  IdCriterio, Mensagem, Data, IdUsuario, NomeUsuario)
		values (@CodigoVariavel, @DocumentoEntidade, @IdCriterio, @Mensagem, getdate(), @IdUsuario, @NomeUsuario);

END
GO
/****** Object:  StoredProcedure [dbo].[LogNovo]    Script Date: 11/30/2009 17:01:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogNovo]
(
@CodigoErroTecnico varchar(100),
@MensagemErro varchar(1000),
@Modulo varchar(50),
@IdUsuario int,
@NomeUsuario varchar(20),
@IdLog int output
)
AS
BEGIN

	Insert into [Log](CodigoErroTecnico, MensagemErroTecnico, Modulo, DataOcorrencia, IdUsuario, NomeUsuario)
		values(@CodigoErroTecnico, @MensagemErro, @Modulo, GETDATE(), @IdUsuario, @NomeUsuario);

	Select @IdLog = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[MapeamentoCriterioRegraLogicaEditar]    Script Date: 11/30/2009 17:01:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MapeamentoCriterioRegraLogicaEditar]
@IdMapeamentoCriterioRegraLogica int output,
@IdRegraLogica int,
@IdCriterioOriginal int,
@IdCriterioTransformado int,
@IdUsuario int
AS
BEGIN
	update MapeamentoCriterioRegraLogica
		set IdRegraLogica = @IdRegraLogica, IdCriterioOriginal = @IdCriterioOriginal,
			IdCriterioTransformado = @IdCriterioTransformado, DataModificacao = GetDate(), IdUsuario = @IdUsuario
	where IdMapeamentoCriterioRegraLogica = @IdMapeamentoCriterioRegraLogica
END

GO
/****** Object:  StoredProcedure [dbo].[MapeamentoCriterioRegraLogicaListar]    Script Date: 11/30/2009 17:01:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MapeamentoCriterioRegraLogicaListar]
(
@IdRegraLogica int,
@IdCriterioOriginal int
)
AS
BEGIN
	Select IdCriterioTransformado from MapeamentoCriterioRegraLogica
	where IdRegraLogica = @IdRegraLogica and IdCriterioOriginal = @IdCriterioOriginal;
END

GO
/****** Object:  StoredProcedure [dbo].[MapeamentoCriterioRegraLogicaNovo]    Script Date: 11/30/2009 17:01:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MapeamentoCriterioRegraLogicaNovo]
@IdMapeamentoCriterioRegraLogica int output,
@IdRegraLogica int,
@IdCriterioOriginal int,
@IdCriterioTransformado int,
@IdUsuario int
AS
BEGIN
	insert into MapeamentoCriterioRegraLogica(IdRegraLogica,
				IdCriterioOriginal, IdCriterioTransformado, DataCriacao, DataModificacao, IdUsuario)
	values(@IdRegraLogica, @IdCriterioOriginal, @IdCriterioTransformado,
				GetDate(), GetDate(), @IdUsuario);
	select @IdMapeamentoCriterioRegraLogica = @@Identity;
END

GO
/****** Object:  StoredProcedure [dbo].[MapeamentoCriterioRegraLogicaRemover]    Script Date: 11/30/2009 17:01:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MapeamentoCriterioRegraLogicaRemover]
@IdMapeamentoCriterioRegraLogica int,
@IdRegraLogica int
AS
BEGIN
	if (@IdMapeamentoCriterioRegraLogica is not null)
	Begin	
		delete from  MapeamentoCriterioRegraLogica
		where IdMapeamentoCriterioRegraLogica = @IdMapeamentoCriterioRegraLogica;
	End
	else
	Begin
		delete from  MapeamentoCriterioRegraLogica
		where IdRegraLogica = @IdRegraLogica;
	End
END

GO
/****** Object:  StoredProcedure [dbo].[ModeloCampanhaListar]    Script Date: 11/30/2009 17:01:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloCampanhaListar]
(
@IdModelo int,
@IdCampanha int
)
AS
BEGIN

	Select  Modelo.IdModelo,
			Modelo.Nome as ModeloNome,
			Modelo.DataCriacao,
			Modelo.DataModificacao,
			Modelo.IdUsuario,
			TipoSegmento.Nome as TipoSegmentoNome,
			TipoSegmento.IdTipoSegmento
	from TipoSegmento inner join Modelo
			on TipoSegmento.IdTipoSegmento = Modelo.IdTipoSegmento
		inner join CampanhaModelo
			on Modelo.IdModelo = CampanhaModelo.IdModelo
		 where (Modelo.IdModelo = @IdModelo or @IdModelo is null)
		 and (CampanhaModelo.IdCampanha = @IdCampanha or @IdCampanha is null)
		 Order by Modelo.IdModelo;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloEditar]    Script Date: 11/30/2009 17:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloEditar]
(
@Nome varchar(40),
@IdUsuario int,
@IdTipoSegmento int,
@IdModelo int
)
AS
BEGIN

	Update Modelo
		set Nome = @Nome, DataModificacao = GETDATE(), IdUsuario = @IdUsuario,
			IdTipoSegmento = @IdTipoSegmento
		where IdModelo = @IdModelo;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloFatorListar]    Script Date: 11/30/2009 17:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloFatorListar]
(
@IdModelo int
)
AS
BEGIN

	Select	ModeloFator.IdModelo,
			ModeloFator.IdFator,
			Fator.IdLinhaNegocio,
			Fator.Codigo,
			Fator.Nome,
			Fator.Descricao,
			Fator.IdTipoFator,
			Fator.Peso,
			Fator.Comentario,
			Fator.DataCriacao,
			Fator.DataModificacao,
			Modelo.IdUsuario
	from Fator inner join ModeloFator
			on Fator.IdFator = ModeloFator.IdFator
		 inner join Modelo
			on ModeloFator.IdModelo = Modelo.IdModelo
		 where (Modelo.IdModelo = @IdModelo or @IdModelo is null)
		 Order by ModeloFator.IdModelo, ModeloFator.IdFator asc;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloFatorNovo]    Script Date: 11/30/2009 17:01:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ModeloFatorNovo]
(
@IdModelo int,
@IdFator int
)
As
BEGIN

	Insert into ModeloFator(IdModelo, IdFator)
		values (@IdModelo, @IdFator);

END
GO
/****** Object:  StoredProcedure [dbo].[ModeloFatorRemover]    Script Date: 11/30/2009 17:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ModeloFatorRemover]
(
@IdModelo int,
@IdFator int
)
As
BEGIN

	Delete from ModeloFator
		where IdModelo = @IdModelo
		and IdFator = @IdFator;

END
GO
/****** Object:  StoredProcedure [dbo].[ModeloListar]    Script Date: 11/30/2009 17:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloListar]
(
@IdModelo int
)
AS
BEGIN

	Select	Modelo.IdModelo,
			Modelo.Nome as ModeloNome,
			Modelo.DataCriacao,
			Modelo.DataModificacao,
			Modelo.IdUsuario,
			TipoSegmento.Nome as TipoSegmentoNome
	from TipoSegmento inner join Modelo
			on TipoSegmento.IdTipoSegmento = Modelo.IdTipoSegmento
		 where (Modelo.IdModelo = @IdModelo or @IdModelo is null)
		 Order by Modelo.IdModelo;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloNovo]    Script Date: 11/30/2009 17:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloNovo]
(
@Nome varchar(40),
@IdUsuario int,
@IdTipoSegmento int,
@IdModelo int output
)
AS
BEGIN

	Insert into Modelo(Nome, DataCriacao, DataModificacao, IdUsuario, IdTipoSegmento)
		values(@Nome, GETDATE(), GETDATE(), @IdUsuario, @IdTipoSegmento);

	Select @IdModelo = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloRelacaoVariavelListar]    Script Date: 11/30/2009 17:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloRelacaoVariavelListar]
(
@IdModelo int,
@IdCampanha int
)
AS
BEGIN

	Select	Modelo.IdModelo,
			Modelo.Nome,
			Modelo.DataCriacao,
			Modelo.DataModificacao,
			Modelo.IdUsuario
		 From Modelo
		 inner join CampanhaModelo
			on Modelo.IdModelo = CampanhaModelo.IdModelo
		 where (Modelo.IdModelo = @IdModelo or @IdModelo is null)
		 and (CampanhaModelo.IdCampanha = isnull(@IdCampanha, CampanhaModelo.IdCampanha))
		 Order by Modelo.IdModelo;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloRemover]    Script Date: 11/30/2009 17:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloRemover]
(
@IdModelo int
)
AS
BEGIN

	Delete from Modelo
		where IdModelo = @IdModelo;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloUsuarioListar]    Script Date: 11/30/2009 17:01:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloUsuarioListar]
(
@IdModelo int
)
AS
BEGIN

	Select  ModeloUsuario.IdModelo,
			ModeloUsuario.IdUsuario,
			Usuario.Nome,
			Usuario.Senha,
			Usuario.MudarSenha,
			Usuario.Email,
			Usuario.DataCriacao,
			Usuario.DataModificacao,
			Usuario.LogUsuario
	from Usuario inner join ModeloUsuario
		 on Usuario.IdUsuario = ModeloUsuario.IdUsuario
		 where (ModeloUsuario.IdModelo = @IdModelo or @IdModelo is null)
		 order by ModeloUsuario.IdModelo, ModeloUsuario.IdUsuario asc;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloUsuarioNovo]    Script Date: 11/30/2009 17:01:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloUsuarioNovo]
(
@IdModelo int,
@IdUsuario int
)
AS
BEGIN

	Insert into ModeloUsuario(IdModelo, IdUsuario)
		values (@IdModelo, @IdUsuario);

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloUsuarioRemover]    Script Date: 11/30/2009 17:01:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloUsuarioRemover]
(
@IdModelo int,
@IdUsuario int
)
AS
BEGIN

	Delete from ModeloUsuario 
		where IdModelo= @IdModelo
		and IdUsuario = isnull(@IdUsuario, IdUsuario);

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloUsuarioSemRelacaoUsuario]    Script Date: 11/30/2009 17:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloUsuarioSemRelacaoUsuario]
(
@IdModelo int
)
AS
BEGIN
	select Usuario.*
	from Usuario
	where Usuario.IdUsuario
	not in(
		select IdUsuario from ModeloUsuario where ModeloUsuario.IdModelo = @IdModelo)
	ORDER BY Usuario.IdUsuario ASC
END

GO
/****** Object:  StoredProcedure [dbo].[ModeloVariavelImportacaoListar]    Script Date: 11/30/2009 17:01:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloVariavelImportacaoListar]
(
@IdTipoDadoVariavel int,
@IdModelo int
)
AS
BEGIN

	select VR.* from Variavel VR
		inner join ModeloVariavel MV on MV.IdVariavel = VR.IdVariavel
		where VR.IdTipoDadoVariavel = @IdTipoDadoVariavel and MV.IdModelo = @IdModelo


END

GO
/****** Object:  StoredProcedure [dbo].[ModeloVariavelListar]    Script Date: 11/30/2009 17:01:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloVariavelListar]
(
@IdModelo int
)
AS
BEGIN

	Select	ModeloVariavel.IdModelo,
			ModeloVariavel.IdVariavel,
			Variavel.IdTipoVariavel,
			TipoVariavel.Nome as NomeTipoVariavel,
			Variavel.IdClasseVariavel,
			ClasseVariavel.Nome as NomeClasseVariavel,
			Variavel.IdTipoSaida,
			TipoSaida.Nome as NomeTipoSaida,
			Variavel.Codigo,
			Variavel.Descricao,
			Variavel.Significado,
			Variavel.MetodoCientificoObtencao,
			Variavel.MetodoPraticoObtencao,
			Variavel.PerguntaSistema,
			Variavel.InteligenciaSistemicaModelo,
			Variavel.Comentario,
			Variavel.DataCriacao,
			Variavel.DataModificacao,
			Variavel.IdUsuario
	from TipoVariavel inner join Variavel
			on TipoVariavel.IdTipoVariavel = Variavel.IdTipoVariavel
		 inner join TipoSaida
			on TipoSaida.IdTipoSaida = Variavel.IdTipoSaida
		 inner join ClasseVariavel
			on ClasseVariavel.IdClasseVariavel = Variavel.IdClasseVariavel
		 inner join ModeloVariavel
			on ModeloVariavel.IdVariavel = Variavel.IdVariavel
		 where (ModeloVariavel.IdModelo = @IdModelo or @IdModelo is null)
		 Order by ModeloVariavel.IdModelo, ModeloVariavel.IdVariavel asc;

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloVariavelNovo]    Script Date: 11/30/2009 17:01:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloVariavelNovo]
(
@IdModelo int,
@IdVariavel int
)
AS
BEGIN

	Insert into ModeloVariavel(IdModelo, IdVariavel)
		values(@IdModelo, @IdVariavel);

END

GO
/****** Object:  StoredProcedure [dbo].[ModeloVariavelRemover]    Script Date: 11/30/2009 17:01:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModeloVariavelRemover]
(
@IdModelo int,
@IdVariavel int
)
AS
BEGIN

	Delete from ModeloVariavel  
		where  IdModelo= @IdModelo
		and IdVariavel = @IdVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilEditar]    Script Date: 11/30/2009 17:01:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilEditar]
(
@Nome varchar(25),
@IdUsuario int,
@IdPerfil int
)
AS
BEGIN

	Update Perfil
		set Nome = @Nome, DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdPerfil = @IdPerfil;

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilListar]    Script Date: 11/30/2009 17:01:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilListar]
(
@IdPerfil int
)
AS
BEGIN

	Select * from Perfil 
		where (IdPerfil = @IdPerfil or @IdPerfil is null);

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilNovo]    Script Date: 11/30/2009 17:01:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilNovo]
(
@Nome varchar(25),
@IdUsuario int,
@IdPerfil int output
)
AS
BEGIN

	Insert into Perfil(Nome, DataCriacao, DataModificacao, IdUsuario)
		values(@Nome, GETDATE(), GETDATE(), @IdUsuario);

	Select @IdPerfil = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilPermissaoSistemaRemover]    Script Date: 11/30/2009 17:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilPermissaoSistemaRemover]
(
@IdPerfil int,
@IdPermissao int
)
AS
BEGIN

	Delete from PerfilPermissaoSistema   
		where IdPerfil = @IdPerfil
		and (IdPermissao = @IdPermissao or @IdPermissao is null);

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilRemover]    Script Date: 11/30/2009 17:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilRemover]
(
@IdPerfil int
)
AS
BEGIN

	Delete from Perfil 
		where IdPerfil = @IdPerfil;

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilSemRelacaoUsuarioListar]    Script Date: 11/30/2009 17:01:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilSemRelacaoUsuarioListar]
(
@IdUsuario int
)
AS
BEGIN
	select Perfil.*
	from Perfil
	where Perfil.IdPerfil
	not in(
		select IdPerfil from PerfilUsuario where PerfilUsuario.IdUsuario = @IdUsuario)
	ORDER BY Perfil.IdPerfil ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PerfilUsuarioListar]    Script Date: 11/30/2009 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	 PROCEDURE [dbo].[PerfilUsuarioListar]
@IdUsuario int  
AS
BEGIN
	select	Perfil.Idperfil,
			Perfil.Nome,
			Perfil.DataCriacao,
			Perfil.DataModificacao,
			Perfil.IdUsuario
			
	 FROM Perfil	inner join PerfilUsuario 
		on	PerfilUsuario.Idperfil = Perfil.Idperfil
		where PerfilUsuario.IdUsuario = @IdUsuario
		order by Perfil.Idperfil asc;
END

GO
/****** Object:  StoredProcedure [dbo].[PerfilUsuarioNovo]    Script Date: 11/30/2009 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[PerfilUsuarioNovo]
@IdUsuario	int,
@IdPerfil	int
AS
BEGIN
	
	Insert into PerfilUsuario(IdUsuario, IdPerfil)
		values (@IdUsuario, @idPerfil);

END

GO
/****** Object:  StoredProcedure [dbo].[PerfilUsuarioRemover]    Script Date: 11/30/2009 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PerfilUsuarioRemover]
(
@IdUsuario	int,
@IdPerfil	int
)
AS
BEGIN

	Delete from PerfilUsuario 
		Where IdUsuario = @IdUsuario
		and (IdPerfil = @IdPerfil or @IdPerfil is null);

END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaListar]    Script Date: 11/30/2009 17:01:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaListar]
@IdPermissao int  
AS
BEGIN
	select * 
	
	FROM PermissaoSistema	
	where IdPermissao = isnull(@IdPermissao, IdPermissao)
	order by IdPermissao asc;		
END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaPerfilListar]    Script Date: 11/30/2009 17:01:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaPerfilListar]
(
@IdPerfil int
)
AS
BEGIN

	Select	PerfilPermissaoSistema.IdPerfil,
			PerfilPermissaoSistema.IdPermissao,
			PermissaoSistema.Nome,
			PermissaoSistema.DataCriacao,
			PermissaoSistema.DataModificacao,
			PermissaoSistema.IdUsuario
	from PermissaoSistema inner join PerfilPermissaoSistema
			on PermissaoSistema.IdPermissao = PerfilPermissaoSistema.IdPermissao
	where (PerfilPermissaoSistema.IdPerfil = @IdPerfil or @IdPerfil is null)
	order by PerfilPermissaoSistema.IdPerfil, PerfilPermissaoSistema.IdPermissao asc;

END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaPerfilNovo]    Script Date: 11/30/2009 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaPerfilNovo]
(
@IdPerfil int,
@IdPermissao int
)
AS
BEGIN

	Insert into PerfilPermissaoSistema(IdPerfil, IdPermissao)
		values(@IdPerfil, @IdPermissao);

END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaPerfilRemover]    Script Date: 11/30/2009 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaPerfilRemover]
(
@IdPerfil int,
@IdPermissao int
)
AS
BEGIN

	Delete from PerfilPermissaoSistema
		where IdPerfil = isnull(@IdPerfil, IdPerfil)
		and IdPermissao = isnull(@IdPermissao, IdPermissao)

END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaSemRelacaoPerfilListar]    Script Date: 11/30/2009 17:01:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaSemRelacaoPerfilListar]
(
@IdPerfil int
)
AS
BEGIN
	select PermissaoSistema.*
	from PermissaoSistema
	where PermissaoSistema.IdPermissao 
	not in(
		select IdPermissao from PerfilPermissaoSistema where PerfilPermissaoSistema.IdPerfil = @IdPerfil)
	ORDER BY PermissaoSistema.IdPermissao ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaSemRelacaoUsuarioListar]    Script Date: 11/30/2009 17:01:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaSemRelacaoUsuarioListar]
(
@IdUsuario int
)
AS
BEGIN
	select PermissaoSistema.*
	from PermissaoSistema
	where PermissaoSistema.IdPermissao 
	not in(
		select IdPermissao from PermissaoUsuario where PermissaoUsuario.IdUsuario = @IdUsuario)
	ORDER BY PermissaoSistema.IdPermissao ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoSistemaUsuarioListar]    Script Date: 11/30/2009 17:01:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoSistemaUsuarioListar]
@IdUsuario int  
AS
BEGIN
	select	PermissaoSistema.IdPermissao,
			PermissaoSistema.Nome,
			PermissaoSistema.DataCriacao,
			PermissaoSistema.DataModificacao,
			PermissaoSistema.IdUsuario
			
	 FROM PermissaoSistema	inner join PermissaoUsuario 
		on	PermissaoUsuario.IdPermissao = PermissaoSistema.IdPermissao
		where PermissaoUsuario.IdUsuario = @IdUsuario
		order by PermissaoSistema.IdPermissao asc;
END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoUsuarioNovo]    Script Date: 11/30/2009 17:01:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoUsuarioNovo]
@IdUsuario	int,
@IdPermissao int
AS
BEGIN
	Insert into PermissaoUsuario(IdUsuario, IdPermissao)
		values (@IdUsuario, @IdPermissao);
END

GO
/****** Object:  StoredProcedure [dbo].[PermissaoUsuarioRemover]    Script Date: 11/30/2009 17:01:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PermissaoUsuarioRemover]
(
@IdUsuario	int,
@IdPermissao	int
)
AS
BEGIN

	Delete from PermissaoUsuario  
		Where IdUsuario = @IdUsuario
		and (IdPermissao = @IdPermissao or @IdPermissao is null);

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoCriterioAderenciaSegmentoListar]    Script Date: 11/30/2009 17:01:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[ProdutoCriterioAderenciaSegmentoListar]
(
@IdSegmento int,
@IdProduto int,
@IdVersaoProdutoFator int
)
as
BEGIN

	Select * from ProdutoCriterioAderenciaSegmento
		Where IdSegmento = @IdSegmento
		and IdProduto = @IdProduto
		and IdVersaoProdutoFator = @IdVersaoProdutoFator

END
GO
/****** Object:  StoredProcedure [dbo].[ProdutoCriterioAderenciaSegmentoNovo]    Script Date: 11/30/2009 17:01:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoCriterioAderenciaSegmentoNovo]
(
@IdProduto int,
@IdCriterioAderencia int,
@IdSegmento int,
@IdVersaoProdutoFator int
)
AS
BEGIN

	Insert into ProdutoCriterioAderenciaSegmento(IdCriterioAderencia, IdSegmento, IdProduto, IdVersaoProdutoFator)
		values(@IdCriterioAderencia, @IdSegmento, @IdProduto, @IdVersaoProdutoFator);

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoCriterioAderenciaSegmentoRemover]    Script Date: 11/30/2009 17:01:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoCriterioAderenciaSegmentoRemover]
(
@IdSegmento int,
@IdProduto int,
@IdVersaoProdutoFator int
)
AS
BEGIN

	Delete from ProdutoCriterioAderenciaSegmento    
		where IdProduto = @IdProduto
		and IdSegmento = @IdSegmento
		and IdVersaoProdutoFator = @IdVersaoProdutoFator;
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoEditar]    Script Date: 11/30/2009 17:01:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoEditar]
@IdProduto int,
@Nome	varchar(40),
@Descricao varchar(80),
@IdUsuario int
AS
BEGIN
	update Produto
		set Nome = @Nome, Descricao = @Descricao, DataModificacao = GETDATE()
		where IdProduto = @IdProduto;
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoListar]    Script Date: 11/30/2009 17:01:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoListar]
@IdProduto int
AS
BEGIN
	select * from Produto
		where (IdProduto = @IdProduto or @IdProduto is null);
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelCriterioAderenciaSegmentoListar]    Script Date: 11/30/2009 17:01:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelCriterioAderenciaSegmentoListar]
(
@IdVersaoProdutoFator int,
@IdSegmento int,
@IdProdutoNivel int
)
AS
BEGIN

	Select * from ProdutoNivelCriterioAderenciaSegmento
	inner join CriterioAderencia 
		on ProdutoNivelCriterioAderenciaSegmento.IdCriterioAderenciaCalculado = CriterioAderencia.Valor
	inner join Criterio
		on CriterioAderencia.IdCriterio = Criterio.IdCriterio
	where ProdutoNivelCriterioAderenciaSegmento.IdVersaoProdutoFator = @IdVersaoProdutoFator
		and ProdutoNivelCriterioAderenciaSegmento.IdSegmento = @IdSegmento
		and ProdutoNivelCriterioAderenciaSegmento.IdProdutoNivel = @IdProdutoNivel

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelCriterioAderenciaSegmentoNovo]    Script Date: 11/30/2009 17:01:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelCriterioAderenciaSegmentoNovo]
(
@IdProdutoNivel int,
@IdCriterioAderencia int,
@IdSegmento int,
@IdCriterioAderenciaCalculado int,
@IdVersaoProdutoFator int
)
AS
BEGIN

	Insert into ProdutoNivelCriterioAderenciaSegmento(IdCriterioAderencia, IdSegmento,
													  IdProdutoNivel, IdVersaoProdutoFator,IdCriterioAderenciaCalculado)
		values(@IdCriterioAderencia, @IdSegmento, @IdProdutoNivel, @IdVersaoProdutoFator, @IdCriterioAderenciaCalculado);

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelCriterioAderenciaSegmentoRemover]    Script Date: 11/30/2009 17:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelCriterioAderenciaSegmentoRemover]
(
@IdProdutoNivel int,
@IdVersaoProdutoFator int,
@IdSegmento int
)
AS
BEGIN

	Delete from ProdutoNivelCriterioAderenciaSegmento
		where IdVersaoProdutoFator = @IdVersaoProdutoFator
		and IdSegmento = @IdSegmento
		and IdProdutoNivel = @IdProdutoNivel;

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelEditar]    Script Date: 11/30/2009 17:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelEditar]
@IdProdutoNivel int,
@Nome varchar(40),
@IdUsuario int
AS
BEGIN
	update ProdutoNivel
		set Nome = @Nome, DataModificacao = GETDATE()
		where IdProdutoNivel = @IdProdutoNivel
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelListar]    Script Date: 11/30/2009 17:01:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelListar]

@IdProdutoNivel int

AS

BEGIN

	Select	pai.IdProdutoNivel,
			Pai.Nome as ProdutoNivelPai,
			RelacaoProdutoNivel.IdFilho,
			Filho.Nome as ProdutoNivelFilho,
			RelacaoProdutoNivelProduto.IdProduto,
			Produto.Nome as Produto
	from RelacaoProdutoNivel inner join ProdutoNivel as Pai
			on RelacaoProdutoNivel.IdProdutoNivel = Pai.IdProdutoNivel
		 inner join ProdutoNivel as Filho
			on RelacaoProdutoNivel.IdFilho = Filho.IdProdutoNivel
		 inner join LinhaNegocioProdutoNivel
			on LinhaNegocioProdutoNivel.IdProdutoNivel = Pai.IdProdutoNivel
		 left join RelacaoProdutoNivelProduto 
			on RelacaoProdutoNivelProduto.IdRelacaoNivelProduto = RelacaoProdutoNivel.IdRelacaoProdutoNivel
		 left join Produto
			on Produto.IdProduto = RelacaoProdutoNivelProduto.IdProduto
		where(pai.IdProdutoNivel = @IdProdutoNivel or @IdProdutoNivel is null)
		
		order by LinhaNegocioProdutoNivel.IdProdutoNivel, 
				 RelacaoProdutoNivel.IdFilho, RelacaoProdutoNivelProduto.IdProduto asc;

END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelListarFilhos]    Script Date: 11/30/2009 17:01:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ProdutoNivelListarFilhos]
(
	@idprodutonivel int
)
as
select * from produtonivel where idprodutonivel in(select idfilho from relacaoprodutonivel where idprodutonivel = @idprodutonivel)



GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelListarPais]    Script Date: 11/30/2009 17:01:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ProdutoNivelListarPais]
as
select * from produtonivel where idprodutonivel not in(select idfilho from relacaoprodutonivel)
GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelListarTodos]    Script Date: 11/30/2009 17:01:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ProdutoNivelListarTodos]
(
	@idProdutoNivel int,
	@nome varchar(40)
)
as
select * from produtonivel
	where (idprodutonivel = @idProdutoNivel or @idProdutoNivel is null)
		and
		  (nome like @nome + '%' or @nome is null)
GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelNovo]    Script Date: 11/30/2009 17:01:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelNovo]
@Nome varchar(40),
@IdUsuario int,
@IdProdutoNivel int output
AS
BEGIN
	insert into ProdutoNivel(Nome, DataCriacao, DataModificacao, IdUsuario)
		values (@Nome, GETDATE(), GETDATE(), @IdUsuario);
		
		select @IdProdutoNivel = @@Identity;
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNivelRemover]    Script Date: 11/30/2009 17:01:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNivelRemover]
@IdProdutoNivel int
AS
BEGIN
	delete from ProdutoNivel
		where (IdProdutoNivel = @IdProdutoNivel or @IdProdutoNivel is null)
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoNovo]    Script Date: 11/30/2009 17:01:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoNovo]
@IdProduto int output,
@CodigoExterno int,
@Nome varchar(80),
@ISBN varchar(30),
@Descricao varchar(80),
@IdUsuario int

AS
BEGIN
	insert into Produto(CodigoExterno, Nome, ISBN, Descricao, DataCriacao, DataModificacao, IdUsuario)
		values (@CodigoExterno, @Nome, @ISBN, @Descricao, GETDATE(), GETDATE(), @IdUsuario);
		
		select @IdProduto = @@Identity;
END

GO
/****** Object:  StoredProcedure [dbo].[ProdutoRemover]    Script Date: 11/30/2009 17:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdutoRemover]
@IdProduto int
AS
BEGIN
	delete from Produto
		where IdProduto = @IdProduto;
END

GO
/****** Object:  StoredProcedure [dbo].[QuadranteEditar]    Script Date: 11/30/2009 17:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuadranteEditar]
(
@Descricao varchar(50),
@XInicial smallint,
@YInicial smallint,
@XFinal smallint,
@YFinal smallint,
@IdGrafico int,
@IdUsuario int,
@IdQuadrante int
)
AS
BEGIN

	Update Quadrante 
		set Descricao = @Descricao, XInicial = @XInicial, YInicial = @YInicial, XFinal = @XFinal,
			YFinal = @YFinal, DataModificacao = GETDATE(), IdGrafico = @IdGrafico, IdUsuario = @IdUsuario
		where IdQuadrante = @IdQuadrante;

END

GO
/****** Object:  StoredProcedure [dbo].[QuadranteNovo]    Script Date: 11/30/2009 17:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuadranteNovo]
(
@Descricao varchar(50),
@XInicial smallint,
@YInicial smallint,
@XFinal smallint,
@YFinal smallint,
@IdGrafico int,
@IdUsuario int,
@IdQuadrante int output
)
AS
BEGIN

	Insert into Quadrante(Descricao, XInicial, YInicial, XFinal, YFinal, DataCriacao,
						  DataModificacao, IdGrafico, IdUsuario)
				values(@Descricao, @XInicial, @YInicial, @XFinal, @YFinal, GETDATE(),
						GETDATE(), @IdGrafico, @IdUsuario);

	Select @IdQuadrante = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[QuadranteRemover]    Script Date: 11/30/2009 17:01:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QuadranteRemover]
(
@IdQuadrante int
)
AS
BEGIN

	Delete from Quadrante 
		where IdQuadrante = @IdQuadrante;

END

GO
/****** Object:  StoredProcedure [dbo].[QuandranteListar]    Script Date: 11/30/2009 17:01:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[QuandranteListar]
(
	@IdQuadrante int,
	@IdGrafico int
)
as
select * from quadrante where (IdGrafico = @IdGrafico or @IdGrafico is null) and (IdQuadrante = @IdQuadrante or @IdQuadrante is null)
GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaEditar]    Script Date: 11/30/2009 17:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegraLogicaEditar]
@IdRegraLogica int,
@IdVariavel int,
@IdCriterio int,
@IdUsuario int
AS
BEGIN
	update RegraLogica
		set IdVariavel = @IdVariavel, IdCriterio = @IdCriterio,
			DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdRegraLogica = @IdRegraLogica;
END

GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaListar]    Script Date: 11/30/2009 17:02:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegraLogicaListar]
@IdRegraLogica int,
@IdVariavel int
AS
BEGIN
	Select * from RegraLogica			
		Where RegraLogica.IdRegraLogica = isnull(@IdRegraLogica, IdRegraLogica)
		and RegraLogica.IdVariavel = isnull(@IdVariavel, IdVariavel)
		order by IdRegraLogica asc;
END

GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaNova]    Script Date: 11/30/2009 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegraLogicaNova]
@IdVariavel int,
@IdCriterio int,
@IdRegraLogica int output,
@IdUsuario int
AS
BEGIN
	Insert into RegraLogica (IdVariavel, IdCriterio, DataCriacao, DataModificacao, IdUsuario)
		values (@IdVariavel, @IdCriterio, GETDATE(), GETDATE(), @IdUsuario);
	
	Select @IdRegraLogica = @@Identity;
END

GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaRemover]    Script Date: 11/30/2009 17:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegraLogicaRemover]
@IdRegraLogica int
AS
BEGIN
	DELETE from RegraLogica
		where IdRegraLogica = @IdRegraLogica;
END

GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaValidar]    Script Date: 11/30/2009 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RegraLogicaValidar]
	@IdRegraLogica int,
	@IdVariavel int,
	@IdCriterio int
as
begin
	select 1 from variavelregralogica
	where IdRegraLogica = @IdRegraLogica and IdVariavel = @IdVariavel and IdCriterio = @IdCriterio;
end

GO
/****** Object:  StoredProcedure [dbo].[RegraLogicaVariavelListar]    Script Date: 11/30/2009 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegraLogicaVariavelListar]
@IdRegraLogica int
AS
BEGIN
	Select * from VariavelRegraLogica 			
		Where (VariavelRegraLogica.IdRegraLogica = @IdRegraLogica)	
		order by IdVariavel asc;		
END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoFatorListar]    Script Date: 11/30/2009 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoFatorListar]
(
@idFator int
)
AS
BEGIN

		Select * from relacaoFator
			where idFator = @idFator	

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoFatorNovo]    Script Date: 11/30/2009 17:02:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[RelacaoFatorNovo]
(
@IdFator int,
@IdFilho int
)
AS
BEGIN

	Insert into RelacaoFator(IdFator, IdFilho)
		values (@IdFator, @IdFilho);

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoFatorRemover]    Script Date: 11/30/2009 17:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoFatorRemover]
(
@IdFator int
)
AS
BEGIN

	Delete from RelacaoFator
		where	(IdFilho = @IdFator)

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelListar]    Script Date: 11/30/2009 17:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelListar]
(
@IdProdutoNivel int
)
AS
BEGIN

	Select RelacaoProdutoNivel.*, ProdutoNivel.Nome from RelacaoProdutoNivel
		inner join ProdutoNivel on 	RelacaoProdutoNivel.IdFilho = ProdutoNivel.IdProdutoNivel
		Where RelacaoProdutoNivel.IdProdutoNivel = @IdProdutoNivel

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelNovo]    Script Date: 11/30/2009 17:02:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelNovo]
(
@IdRelacaoProdutoNivel int output,
@IdProdutoNivel int,
@IdFilho int
)
AS
BEGIN

	Insert into RelacaoProdutoNivel(IdProdutoNivel, IdFilho)
		values (@IdProdutoNivel, @IdFilho);

	Select @IdRelacaoProdutoNivel = @@Identity;

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelProdutoListar]    Script Date: 11/30/2009 17:02:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelProdutoListar]
(
@IdRelacaoNivelProduto int
)
AS
BEGIN

	Select RelacaoProdutoNivelProduto.*, Produto.Nome from RelacaoProdutoNivelProduto
		inner join Produto on RelacaoProdutoNivelProduto.IdProduto = Produto.IdProduto
		where IdRelacaoNivelProduto = @IdRelacaoNivelProduto

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelProdutoNovo]    Script Date: 11/30/2009 17:02:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelProdutoNovo]
(
@IdRelacaoNivelProduto int,
@IdProduto int
)
AS
BEGIN

	Insert into RelacaoProdutoNivelProduto(IdRelacaoNivelProduto ,IdProduto)
		values (@IdRelacaoNivelProduto, @IdProduto);

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelProdutoRemover]    Script Date: 11/30/2009 17:02:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelProdutoRemover]
(
@IdRelacaoNivelProduto int,
@IdProduto int
)
AS
BEGIN

	Delete from RelacaoProdutoNivelProduto
		where	(IdRelacaoNivelProduto = isnull(@IdRelacaoNivelProduto, IdRelacaoNivelProduto))
		and		(IdProduto = @IdProduto);

END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoProdutoNivelRemover]    Script Date: 11/30/2009 17:02:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoProdutoNivelRemover]
(
@IdRelacaoProdutoNivel int,
@IdProdutoNivel int
)
AS
BEGIN

	Delete from RelacaoProdutoNivel
		where	(IdRelacaoProdutoNivel = isnull(@IdRelacaoProdutoNivel, IdRelacaoProdutoNivel) )
		and		(IdProdutoNivel = @IdProdutoNivel)
		or		(IdFilho = @IdProdutoNivel);

END
GO
/****** Object:  StoredProcedure [dbo].[RelacaoVariavelListar]    Script Date: 11/30/2009 17:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoVariavelListar]
@IdVariavel int
AS
BEGIN	
	SELECT RelacaoVariavel.IdVariavel as IdPai,
			RelacaoVariavel.IdFIlho, 
			Variavel.IdTipoVariavel,
			Variavel.IdClasseVariavel,
			Variavel.IdTipoSaida,
			Variavel.IDTipoDadoVariavel,
			Variavel.Descricao,
			Variavel.IdVariavel as IdFilho
	from RelacaoVariavel 
	inner join variavel on
	Variavel.IdVariavel = RelacaoVariavel.IdFilho			
	where RelacaoVariavel.IdVariavel = @IdVariavel;
END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoVariavelNovo]    Script Date: 11/30/2009 17:02:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoVariavelNovo]
@IdVariavel int,
@IdFilho int
AS
BEGIN	
	insert into RelacaoVariavel(IdVariavel, IdFilho)
	values  (@IdVariavel, @IdFilho)
END

GO
/****** Object:  StoredProcedure [dbo].[RelacaoVariavelRemover]    Script Date: 11/30/2009 17:02:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RelacaoVariavelRemover]
@IdVariavel int,
@IdFilho int
AS
BEGIN	
	delete from RelacaoVariavel
	where  (IdVariavel = isnull(@IdVariavel, IdVariavel) and
			IdFilho = isnull(@IdFilho, IdFilho));
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoEditar]    Script Date: 11/30/2009 17:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoEditar]
@TamanhoMercado int,
@Codigo int,
@FatorAtratividade int,
@IdModelo int,
@IdUsuario int,
@IdSegmento int
AS
BEGIN
	update Segmento 
		set		TamanhoMercado = isnull(@TamanhoMercado, TamanhoMercado),
				Codigo = isnull(@Codigo, Codigo),
				FatorAtratividade = isnull(@FatorAtratividade, FatorAtratividade),
				DataModificacao = Getdate(),
				IdModelo = isnull(@IdModelo, IdModelo),
				IdUsuario = isnull(@IdUsuario, IdUsuario) 		
		where Idsegmento = @IdSegmento;
		
END


GO
/****** Object:  StoredProcedure [dbo].[SegmentoEntidadeListar]    Script Date: 11/30/2009 17:02:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SegmentoEntidadeListar]
@IdSegmento int
AS
BEGIN
	select 
	SegmentoEntidade.IdSegmento,
	Entidade.IdEntidade,
	Entidade.Nome,
	Entidade. Documento,
	Entidade.DataCriacao,
	Entidade.DataModificacao
	
	FROM SegmentoEntidade
	INNER JOIN Entidade on Entidade.IdEntidade = SegmentoEntidade.IdEntidade
	
	where SegmentoEntidade.Idsegmento = isnull(@IdSegmento, SegmentoEntidade.Idsegmento) 
	order by SegmentoEntidade.IdSegmento asc, Entidade.IdEntidade asc;		
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoEntidadeNovo]    Script Date: 11/30/2009 17:02:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoEntidadeNovo]
(
@IdEntidade int,
@IdSegmento int
)
AS
BEGIN

	Insert into SegmentoEntidade(IdSegmento, IdEntidade)
		values (@IdSegmento, @IdEntidade);

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoEntidadeRemover]    Script Date: 11/30/2009 17:02:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoEntidadeRemover]
(
@IdEntidade int,
@IdSegmento int
)
AS
BEGIN

	Delete from SegmentoEntidade
		where IdSegmento = @IdSegmento
		and IdEntidade = @IdEntidade;

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoFatorListar]    Script Date: 11/30/2009 17:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoFatorListar]
@IdSegmento int,
@IdFator int
AS
BEGIN
	select 
	SegmentoFator.IdSegmento,
	Fator.IdFator,
	Fator.Codigo,
	Fator.Nome,
	Fator.Descricao,
	Fator.Peso,
	Fator.IdTipoFator,
	Fator.Comentario,
	SegmentoFator.IdCriterio,
	Fator.DataCriacao,
	Fator.DataModificacao,
	Fator.IdUsuario
	
	FROM SegmentoFator
	INNER JOIN Fator on Fator.IdFator = SegmentoFator.IdFator
	
	where SegmentoFator.Idsegmento = isnull(@IdSegmento, SegmentoFator.Idsegmento) 
		and SegmentoFator.IdFator = isnull(@IdFator, SegmentoFator.IdFator) 
	order by IdSegmento asc;		
END
GO
/****** Object:  StoredProcedure [dbo].[SegmentoFatorNovo]    Script Date: 11/30/2009 17:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoFatorNovo]
@IdSegmento int,
@IdFator int,
@IdCriterio int
AS
BEGIN
	insert 
		into SegmentoFator (IdSegmento, IdFator, IdCriterio) 
		Values (@IdSegmento, @IdFator, @IdCriterio);		
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoFatorRemover]    Script Date: 11/30/2009 17:02:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoFatorRemover]
@IdSegmento int,
@IdFator int
AS
BEGIN
	delete from SegmentoFator	
		where IdSegmento = @IdSegmento and IdFator = @IdFator
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoListar]    Script Date: 11/30/2009 17:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoListar]
(
@IdSegmento int,
@IdModelo int
)
AS
BEGIN

	Select * from Segmento
		Where IdSegmento = isnull(@IdSegmento, IdSegmento)
		and IdModelo = isnull(@IdModelo, IdModelo)

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoModeloListar]    Script Date: 11/30/2009 17:02:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoModeloListar]
@IdSegmento int,
@IdModelo int 
AS
BEGIN
	select * from Segmento 		
	where IdSegmento = isnull (@IdSegmento, IdSegmento) 
			and IdModelo = isnull(@IdModelo, IdModelo)
	order by IdSegmento asc, IdModelo asc;
		
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoNovo]    Script Date: 11/30/2009 17:02:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoNovo]
@TamanhoMercado int,
@Codigo varchar(150),
@FatorAtratividade int,
@IdModelo int,
@IdUsuario int,
@IdSegmento int output
AS
BEGIN
	insert 
		into Segmento (TamanhoMercado, Codigo, FatorAtratividade,
							 DataCriacao, DataModificacao,
							IdModelo, IdUsuario) 
		Values (@TamanhoMercado, @Codigo, @FatorAtratividade,
							Getdate(), Getdate(),
							@IdModelo, @IdUsuario);
		select @IdSegmento = @@Identity;
		
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoProdutoCriterioAderenciaListar]    Script Date: 11/30/2009 17:02:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoProdutoCriterioAderenciaListar]
@IdSegmento int
AS
BEGIN
	SELECT * from  ProdutoCriterioAderenciaSegmento 
	where IdSegmento = @IdSegmento
	order by IdSegmento asc;
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoProdutoNivelCriterioAderenciaListar]    Script Date: 11/30/2009 17:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoProdutoNivelCriterioAderenciaListar]
@IdSegmento int
AS
BEGIN
	SELECT * from  ProdutoNivelCriterioAderenciaSegmento 
	where IdSegmento = @IdSegmento
	order by IdSegmento asc;
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRazaoAderenciaProdutoListar]    Script Date: 11/30/2009 17:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoRazaoAderenciaProdutoListar]
(
@IdSegmento int,
@IdProduto int,
@IdVersaoProdutoFator int
)
AS
BEGIN

	Select	--Segmento.IdModelo,
			--Segmento.IdSegmento,
			--ProdutoCriterioAderenciaSegmento.IdProduto,								
			case
				when 
					CriterioAderenciaPrincipal.Valor = 0 then
						0 
				when 
					(select sum(Valor)
						from Segmento Seg
					inner join ProdutoCriterioAderenciaSegmento
						on Seg.IdSegmento = ProdutoCriterioAderenciaSegmento.IdSegmento
					inner join CriterioAderencia as CriterioAderenciaPrincipal
						on ProdutoCriterioAderenciaSegmento.IdCriterioAderencia = CriterioAderenciaPrincipal.IdCriterioAderencia
					where Seg.IdSegmento = Segmento.IdSegmento
					) = 0 then
						0
			else					
				convert(float, CriterioAderenciaPrincipal.Valor) / 
				convert(float, (select sum(Valor)
						from Segmento Seg
					inner join ProdutoCriterioAderenciaSegmento
						on Seg.IdSegmento = ProdutoCriterioAderenciaSegmento.IdSegmento
					inner join CriterioAderencia as CriterioAderenciaPrincipal
						on ProdutoCriterioAderenciaSegmento.IdCriterioAderencia = CriterioAderenciaPrincipal.IdCriterioAderencia
					where Seg.IdSegmento = Segmento.IdSegmento))				
			end
			as RazaoAderencia 
	from Segmento 
		inner join ProdutoCriterioAderenciaSegmento
			on Segmento.IdSegmento = ProdutoCriterioAderenciaSegmento.IdSegmento
		inner join CriterioAderencia as CriterioAderenciaPrincipal
			on ProdutoCriterioAderenciaSegmento.IdCriterioAderencia = CriterioAderenciaPrincipal.IdCriterioAderencia
		where 
			Segmento.IdSegmento = @IdSegmento
		and ProdutoCriterioAderenciaSegmento.IdProduto = @IdProduto
		and ProdutoCriterioAderenciaSegmento.IdVersaoProdutoFator = @IdVersaoProdutoFator
		order by IdProduto ASC
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRazaoAderenciaProdutoNivelListar]    Script Date: 11/30/2009 17:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoRazaoAderenciaProdutoNivelListar]
(
@IdSegmento int,
@IdProdutoNivel int,
@IdVersaoProdutoFator int
)
AS
BEGIN

	Select	--Segmento.IdModelo,
			--Segmento.IdSegmento,
			--ProdutoNivelCriterioAderenciaSegmento.IdProdutoNivel,								
			case
				when 
					CriterioAderenciaPrincipal.Valor = 0 then
						0 
				when 
					(select sum(Valor)
						from Segmento Seg
					inner join ProdutoNivelCriterioAderenciaSegmento
						on Seg.IdSegmento = ProdutoNivelCriterioAderenciaSegmento.IdSegmento
					inner join CriterioAderencia as CriterioAderenciaPrincipal
						on ProdutoNivelCriterioAderenciaSegmento.IdCriterioAderenciaCalculado = CriterioAderenciaPrincipal.IdCriterioAderencia
					where Seg.IdSegmento = Segmento.IdSegmento
					) = 0 then
						0
			else					
				convert(float, CriterioAderenciaPrincipal.Valor) / 
				convert(float, (select sum(Valor)
						from Segmento Seg
					inner join ProdutoNivelCriterioAderenciaSegmento
						on Seg.IdSegmento = ProdutoNivelCriterioAderenciaSegmento.IdSegmento
					inner join CriterioAderencia as CriterioAderenciaPrincipal
						on ProdutoNivelCriterioAderenciaSegmento.IdCriterioAderenciaCalculado = CriterioAderenciaPrincipal.IdCriterioAderencia
					where Seg.IdSegmento = Segmento.IdSegmento))				
			end
			as RazaoAderencia 
	from Segmento 
		inner join ProdutoNivelCriterioAderenciaSegmento
			on Segmento.IdSegmento = ProdutoNivelCriterioAderenciaSegmento.IdSegmento
		inner join CriterioAderencia as CriterioAderenciaPrincipal
			on ProdutoNivelCriterioAderenciaSegmento.IdCriterioAderenciaCalculado = CriterioAderenciaPrincipal.IdCriterioAderencia
		where 
			Segmento.IdSegmento = @IdSegmento 
		and ProdutoNivelCriterioAderenciaSegmento.IdProdutoNivel = @IdProdutoNivel
		and ProdutoNivelCriterioAderenciaSegmento.IdVersaoProdutoFator = @IdVersaoProdutoFator 
		order by IdProdutoNivel ASC
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRegraLogicaListar]    Script Date: 11/30/2009 17:02:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoRegraLogicaListar]
(
@IdSegmento int,
@IdRegraLogica int
)
AS
BEGIN

	Select * from SegmentoRegraLogica
		where IdSegmento = isnull(@IdSegmento, IdSegmento)
		and IdRegraLogica = isnull(@IdRegraLogica, IdRegraLogica)

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRegraLogicaNovo]    Script Date: 11/30/2009 17:02:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SegmentoRegraLogicaNovo]
(
@IdSegmento int,
@IdRegraLogica int
)
AS
BEGIN

	Insert into SegmentoRegraLogica(IdSegmento, IdRegraLogica)
		values (@IdSegmento, @IdRegraLogica);

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRegraLogicaRemover]    Script Date: 11/30/2009 17:02:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SegmentoRegraLogicaRemover]
(
@IdSegmento int
)
AS
BEGIN

	Delete from SegmentoRegraLogica
		where IdSegmento = @IdSegmento

END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoRemover]    Script Date: 11/30/2009 17:02:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SegmentoRemover]
@IdSegmento int,
@Codigo varchar(150),
@IdModelo int,
@IdUsuario int
AS
BEGIN
	delete from Segmento 		
	where Idsegmento = isnull(@IdSegmento, IdSegmento)
	and Codigo = isnull(@Codigo, Codigo)
	and IdModelo = isnull(@IdModelo, IdModelo)
	and IdUsuario = isnull(@IdUsuario, IdUsuario);
		
END

GO
/****** Object:  StoredProcedure [dbo].[SegmentoTamanhoMercadoControlar]    Script Date: 11/30/2009 17:02:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SegmentoTamanhoMercadoControlar]
@IdSegmento int
as
begin
	update Segmento 
		set		TamanhoMercado = TamanhoMercado + 1
		where Idsegmento = @IdSegmento;
end

GO
/****** Object:  StoredProcedure [dbo].[TipoComparacaoRegraLogicaListar]    Script Date: 11/30/2009 17:02:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoComparacaoRegraLogicaListar]
@IdTipoComparacaoRegraLogica int
AS
BEGIN	
	SELECT * from TipoComparacaoRegraLogica
	where IdTipoComparacaoRegraLogica = @IdTipoComparacaoRegraLogica;
END

GO
/****** Object:  StoredProcedure [dbo].[TipoCriterioVariavelListar]    Script Date: 11/30/2009 17:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoCriterioVariavelListar]
@IdTipoCriterioVariavel int
AS
BEGIN	
	SELECT * from TipoCriterioVariavel
	where IdTipoCriterioVariavel = isnull(@IdTipoCriterioVariavel, IdTipoCriterioVariavel);
END

GO
/****** Object:  StoredProcedure [dbo].[TipoDadoVariavelListar]    Script Date: 11/30/2009 17:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoDadoVariavelListar]
AS
BEGIN	
	SELECT * from TipoDadoVariavel;
END

GO
/****** Object:  StoredProcedure [dbo].[TipoFatorListar]    Script Date: 11/30/2009 17:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoFatorListar]
@IdTipoFator int
AS
BEGIN	
	SELECT * from TipoFator
	where IdTipoFator = isNull(@IdTipoFator, IdTipoFator);
END

GO
/****** Object:  StoredProcedure [dbo].[TipoOperadorCalculoListar]    Script Date: 11/30/2009 17:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoOperadorCalculoListar]
@IdTipoOperadorCalculo int
AS
BEGIN	
	SELECT * from TipoOperadorCalculo
	where IdTipoOperadorCalculo = isnull(@IdTipoOperadorCalculo, IdTipoOperadorCalculo);
END

GO
/****** Object:  StoredProcedure [dbo].[TipoSaidaListar]    Script Date: 11/30/2009 17:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoSaidaListar]

AS
BEGIN	
	SELECT * from TipoSaida;
END

GO
/****** Object:  StoredProcedure [dbo].[TipoSegmentoEditar]    Script Date: 11/30/2009 17:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoSegmentoEditar]
(
@Nome varchar(60),
@IdUsuario int,
@IdTipoSegmento int
)
AS
BEGIN

	Update TipoSegmento 
		set Nome = @Nome, DataModificacao = GETDATE(), IdUsuario = @IdUsuario
		where IdTipoSegmento = @IdTipoSegmento;

END

GO
/****** Object:  StoredProcedure [dbo].[TipoSegmentoListar]    Script Date: 11/30/2009 17:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoSegmentoListar]
@IdLinhaNegocio int
AS
BEGIN	
	SELECT * from TipoSegmento
	where IdLinhaNegocio = Isnull(@IdLinhaNegocio, IdLinhaNegocio);
END

GO
/****** Object:  StoredProcedure [dbo].[TipoSegmentoModeloListar]    Script Date: 11/30/2009 17:02:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoSegmentoModeloListar]
(
@IdModelo int
)
AS
BEGIN

	select TipoSegmento.* from TipoSegmento
		inner join Modelo
		on Modelo.IdTipoSegmento = TipoSegmento.IdTipoSegmento
	where Modelo.IdModelo = @IdModelo


END

GO
/****** Object:  StoredProcedure [dbo].[TipoSegmentoNovo]    Script Date: 11/30/2009 17:02:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[TipoSegmentoNovo]
@Nome varchar(30),
@IdLinhaNegocio int,
@IdUsuario int,
@IdTipoSegmento int output
AS
BEGIN
	insert 
		into TipoSegmento (Nome, IdLinhaNegocio, DataCriacao, DataModificacao, IdUsuario) 
		Values (@Nome, @IdLinhaNegocio, Getdate(), Getdate(), @IdUsuario);
		select @IdTipoSegmento = @@Identity;
		
END

GO
/****** Object:  StoredProcedure [dbo].[TipoSegmentoRemover]    Script Date: 11/30/2009 17:02:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoSegmentoRemover]
(
@IdTipoSegmento int
)
AS
BEGIN

	Delete from TipoSegmento 
		where IdTipoSegmento = @IdTipoSegmento;

END

GO
/****** Object:  StoredProcedure [dbo].[TipoStatusEntidadeListar]    Script Date: 11/30/2009 17:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoStatusEntidadeListar]
(
@IdTipoStatusEntidade int
)
AS
BEGIN

	Select * from TipoStatusEntidade
		where IdTipoStatusEntidade = isnull(@IdTipoStatusEntidade, IdTipoStatusEntidade);

END
GO
/****** Object:  StoredProcedure [dbo].[TipoStatusEntidadeNovo]    Script Date: 11/30/2009 17:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoStatusEntidadeNovo]
(
@Nome int,
@IdUsuario int
)
AS
BEGIN

	Insert into TipoStatusEntidade(Nome, DataCriacao, DataModificacao, IdUsuario)
		values (@Nome, GETDATE(), GETDATE(), @IdUsuario);

END
GO
/****** Object:  StoredProcedure [dbo].[TipoStatusUsuarioListar]    Script Date: 11/30/2009 17:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoStatusUsuarioListar]
@IdTipoStatusUsuario int
AS
BEGIN
	SELECT * from TipoStatusUsuario
	where IdTipoStatusUsuario = isnull(@IdTipoStatusUsuario, IdTipoStatusUsuario)
	order by IdTipoStatusUsuario asc;
END

GO
/****** Object:  StoredProcedure [dbo].[TipoVariavelListar]    Script Date: 11/30/2009 17:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TipoVariavelListar]
AS
BEGIN	
	SELECT * from TipoVariavel;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioDesabilitar]    Script Date: 11/30/2009 17:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioDesabilitar]
@IdUsuario int
AS
BEGIN
	update Usuario
		set IdTipoStatusUsuario = 2
	where IdUsuario = @IdUsuario;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioEditar]    Script Date: 11/30/2009 17:02:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioEditar]
@Nome	varchar(40),
@NomeUsuario varchar(20),
@Senha	varchar(40),
@MudarSenha bit,
@Email	varchar(50),
@IdTipoStatusUsuario int,
@LogUsuario	varchar(20),
@IdUsuario int
AS
BEGIN
	update Usuario
		set Nome = isnull(@Nome, Nome),
			NomeUsuario = isnull(@NomeUsuario, NomeUsuario),
			Senha = isnull(@Senha, Senha),
			MudarSenha = isnull(@MudarSenha, MudarSenha),
			Email = isnull(@Email, Email),
			IdTipoStatusUsuario = isnull(@IdTipoStatusUsuario, IdTipoStatusUsuario),
			DataModificacao = GetDate(), 
			LogUsuario = isnull(@LogUsuario, LogUsuario)
			
	where IdUsuario = @IdUsuario;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioLinhaNegocioListar]    Script Date: 11/30/2009 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioLinhaNegocioListar]
@IdUsuario int
AS
BEGIN
	SELECT IdLinhaNegocio, IdUsuario from LinhaNegocio
	where IdUsuario = @IdUsuario
	order by IdLinhaNegocio asc;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioListar]    Script Date: 11/30/2009 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioListar]
@IdUsuario int
AS
BEGIN
	SELECT * from Usuario 
	where IdUsuario = isnull(@IdUsuario, IdUsuario)
	order by IdUsuario asc;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioNovo]    Script Date: 11/30/2009 17:02:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioNovo]
@Nome	varchar(20),
@Senha	varchar(40),
@MudarSenha bit,
@Email	varchar(50),
@IdTipoStatusUsuario int,
@LogUsuario	varchar(20),
@NomeUsuario varchar(20),
@IdUsuario int output
AS
BEGIN
	insert into Usuario(Nome, Senha, MudarSenha, Email, 
						IdTipoStatusUsuario, DataCriacao, 
						DataModificacao, LogUsuario, NomeUsuario)
	values(@Nome, @Senha, @MudarSenha, @Email, 
			@IdTipoStatusUsuario, GetDate(), 
			GetDate(), @LogUsuario, @NomeUsuario);
	select @IdUsuario = @@Identity;
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioPerfilListar]    Script Date: 11/30/2009 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioPerfilListar]
(
@IdUsuario int
)
AS
BEGIN

	Select	Perfil.IdPerfil,
			Perfil.Nome,
			Perfil.DataCriacao,
			Perfil.DataModificacao,
			Perfil.IdUsuario
	from Perfil inner join PerfilUsuario
		on Perfil.IdPerfil = PerfilUsuario.IdPerfil
		where (Perfil.IdPerfil = @IdUsuario)
		order by Perfil.IdPerfil asc;

END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioPermissaoListar]    Script Date: 11/30/2009 17:02:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioPermissaoListar]
(
@IdUsuario int
)
AS
BEGIN
	--SELECT PTotal.IdPermissao,
	SELECT
	MenuAplicacao.IdMenuAplicacao,
	MenuAplicacao.Nome, 
	MenuAplicacao.Endereco,
	(select RelacaoMenu.IdMenuAplicacao from RelacaoMenu where RelacaoMenu.IdFilho =  MenuAplicacao.IdMenuAplicacao) AS IdPai
	FROM
	(SELECT 
	P.IdPermissao	
	FROM	
	((Select	A.IdPermissao
	from 
	PermissaoSistema A
	inner join PerfilPermissaoSistema on A.IdPermissao = PerfilPermissaoSistema.IdPermissao
	inner join PerfilUsuario on PerfilUsuario.IdPerfil = PerfilPermissaoSistema.IdPerfil	
	where PerfilUsuario.IdUsuario = @IdUsuario)
	UNION ALL
	(Select	B.IdPermissao
	from 
	PermissaoSistema B
	inner join PermissaoUsuario on B.IdPermissao = PermissaoUsuario.IdPermissao
	where PermissaoUsuario.IdUsuario = @IdUsuario)) AS P
	group by P.IdPermissao) AS PTotal
	inner join PermissaoMenuAplicacao on PermissaoMenuAplicacao.IdPermissao = PTotal.IdPermissao
	inner join MenuAplicacao on MenuAplicacao.IdMenuAplicacao = PermissaoMenuAplicacao.IdMenuAplicacao	
	where MenuAplicacao.Exibir = 1
	group by MenuAplicacao.Ordem, MenuAplicacao.IdMenuAplicacao, MenuAplicacao.Nome, MenuAplicacao.Endereco 
	order by MenuAplicacao.Ordem, MenuAplicacao.IdMenuAplicacao, MenuAplicacao.Nome, MenuAplicacao.Endereco
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioRemover]    Script Date: 11/30/2009 17:02:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioRemover]
@IdUsuario int
AS
BEGIN

	delete from Usuario
	Where IdUsuario = @IdUsuario;

END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioValidar]    Script Date: 11/30/2009 17:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioValidar]
@NomeUsuario varchar(20),
@Senha varchar(40)
AS
BEGIN
	select Usuario.*,
			LinhaNegocioUsuario.IdLinhaNegocio	
	from Usuario left join LinhaNegocioUsuario on
	LinhaNegocioUsuario.IdUsuario = Usuario.IdUsuario
	Where NomeUsuario = @NomeUsuario and Senha = @Senha	
END

GO
/****** Object:  StoredProcedure [dbo].[VariavelCalculoVariavelListar]    Script Date: 11/30/2009 17:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[VariavelCalculoVariavelListar]
@IdVariavel int
as
begin
	select VariavelCalculovariavel.IdVariavel, VariavelCalculovariavel.IdTipoOperadorCalculo, EntidadeVariavel.Valor 
	from	VariavelCalculoVariavel
	inner join CalculoVariavel on 
	VariavelCalculoVariavel.IdCalculoVariavel = CalculoVariavel.IdCalculoVariavel
	inner join EntidadeVariavel on
	EntidadeVariavel.IdVariavel = VariavelCalculovariavel.IdVariavel 
	where CalculoVariavel.Idvariavel = @IdVariavel
	order by OrdemOperacao asc;
end
GO
/****** Object:  StoredProcedure [dbo].[VariavelCalculoVariavelNovo]    Script Date: 11/30/2009 17:02:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[VariavelCalculoVariavelNovo]
@IdVariavel int,
@IdCalculoVariavel int,
@IdTipoOperadorCalculo int,
@OrdemOperacao int,
@AbrirParentese bit,
@FecharParentese bit
as
begin
	insert into VariavelCalculoVariavel(
		IdVariavel, IdCalculoVariavel, IdTipoOperadorCalculo,
		AbrirParenteses, FecharParenteses, OrdemOperacao)
	values (@IdVariavel, @IdCalculoVariavel, @IdTipoOperadorCalculo, @AbrirParentese, @FecharParentese, @OrdemOperacao)
end
GO
/****** Object:  StoredProcedure [dbo].[VariavelCalculoVariavelRemove]    Script Date: 11/30/2009 17:02:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VariavelCalculoVariavelRemove]
@IdCalculoVariavel int
as
begin
	delete from  VariavelCalculoVariavel
	where IdCalculoVariavel = @IdCalculoVariavel;
end
GO
/****** Object:  StoredProcedure [dbo].[VariavelCriterioListar]    Script Date: 11/30/2009 17:02:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelCriterioListar]
@IdVariavel int
AS
BEGIN
	Select	
		CriterioVariavel.IdVariavel,
		Criterio.IdCriterio,
		Criterio.Nome,
		Criterio.DataCriacao,
		Criterio.DataModificacao,
		Criterio.IdUsuario
	from CriterioVariavel
		inner join 
			Criterio on CriterioVariavel.IdCriterio = Criterio.IdCriterio	
					
		Where CriterioVariavel.IdVariavel = isnull(@IdVariavel, CriterioVariavel.IdVariavel)
		
		order by CriterioVariavel.IdVariavel asc;
		
END

GO
/****** Object:  StoredProcedure [dbo].[VariavelEditar]    Script Date: 11/30/2009 17:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelEditar]
@IdVariavel int,
@IdTipoVariavel int,
@IdClasseVariavel int,
@IdTipoSaida int,
@Codigo varchar(25),
@Descricao varchar(60),
@Significado varchar (500),
@MetodoCientificoObtencao varchar(60),
@MetodoPraticoObtencao varchar(60),
@PerguntaSistema varchar(60),
@InteligenciaSistemicaModelo varchar(60),
@Comentario varchar (500),
@ColunaImportacao smallint,
@IdUsuario int
AS
BEGIN

	update Variavel
		Set
			IdTipoVariavel = @IdTipoVariavel, 
			IdClasseVariavel = @IdClasseVariavel,
			IdTipoSaida = @IdTipoSaida, 
			Codigo = @Codigo, 
			Descricao = @Descricao, 
			Significado = @Significado, 
			MetodoCientificoObtencao = @MetodoCientificoObtencao, 
			MetodoPraticoObtencao = @MetodoPraticoObtencao, 
			PerguntaSistema = @PerguntaSistema, 
			InteligenciaSistemicaModelo = @InteligenciaSistemicaModelo, 
			Comentario = @Comentario, 
			DataModificacao = GETDATE(), 
			ColunaImportacao = @ColunaImportacao,
			IdUsuario = @IdUsuario

	Where IdVariavel = @IdVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[VariavelListar]    Script Date: 11/30/2009 17:02:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelListar]
@Codigo varchar(25),
@Descricao Varchar(60),
@IdLinhaNegocio int,
@IdModelo int

AS

BEGIN

	Select
		Variavel.IdVariavel,
		Variavel.IdTipoVariavel,
		Variavel.IdClasseVariavel,
		Variavel.IdTipoSaida,
		Variavel.Codigo,
		Variavel.Descricao,
		Variavel.Significado,
		Variavel.MetodoCientificoObtencao,
		Variavel.MetodoPraticoObtencao,
		Variavel.PerguntaSistema,
		Variavel.InteligenciaSistemicaModelo,
		Variavel.Comentario,
		Variavel.DataCriacao,
		Variavel.DataModificacao,
		Variavel.IdUsuario,
		Variavel.ColunaImportacao,
		Variavel.IdTipoDadoVariavel
--		(select IdVariavel from RelacaoVariavel where RelacaoVariavel.IdFilho = Variavel.IdVariavel) AS IdPai		
	from Variavel 
	inner join ClasseVariavel on ClasseVariavel.IdClasseVariavel = Variavel.IdClasseVariavel
	inner join LinhaNegocioClasseVariavel on LinhaNegocioClasseVariavel.IdClasseVariavel = ClasseVariavel.IdClasseVariavel
	inner join ModeloVariavel on ModeloVariavel.IdVariavel = Variavel.IdVariavel
	where 
      LinhaNegocioClasseVariavel.IdLinhaNegocio = @IdLinhaNegocio
	and ModeloVariavel.IdModelo = @IdModelo
	and Variavel.Codigo = isnull(@Codigo, Variavel.Codigo)
	and Variavel.Descricao = isnull(@Descricao, Variavel.Descricao)
		order by Variavel.IdVariavel asc;
		
END

GO
/****** Object:  StoredProcedure [dbo].[VariavelModeloListar]    Script Date: 11/30/2009 17:02:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[VariavelModeloListar]
@IdModelo int,
@IdLinhaNegocio int
as
begin
select Variavel.*,
		RelacaoVariavel.IdVariavel as IdPai
from Variavel
left join RelacaoVariavel on RelacaoVariavel.IdFilho = variavel.IdVariavel
inner join ClasseVariavel on ClasseVariavel.IdClasseVariavel = Variavel.IdClasseVariavel
inner join LinhaNegocioClasseVariavel on LinhaNegocioClasseVariavel.IdClasseVariavel = ClasseVariavel.IdClasseVariavel
inner join ModeloVariavel on ModeloVariavel.IdVariavel = Variavel.IdVariavel
where 
      LinhaNegocioClasseVariavel.IdLinhaNegocio = @IdLinhaNegocio
and ModeloVariavel.IdModelo = @IdModelo
--and not exists(select 1 from RelacaoVariavel where RelacaoVariavel.IdFilho = Variavel.IdVariavel);
end

GO
/****** Object:  StoredProcedure [dbo].[VariavelNova]    Script Date: 11/30/2009 17:02:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelNova]
@IdVariavel int output,
@IdTipoVariavel int,
@IdClasseVariavel int,
@IdTipoSaida int,
@Codigo varchar(25),
@Descricao varchar(60),
@Significado varchar (500),
@MetodoCientificoObtencao varchar(60),
@MetodoPraticoObtencao varchar(60),
@PerguntaSistema varchar(60),
@InteligenciaSistemicaModelo varchar(60),
@Comentario varchar (500),
@ColunaImportacao smallint,
@IdTipoDadoVariavel int,
@IdUsuario int
AS
BEGIN

	Insert into Variavel(IdTipoVariavel, IdClasseVariavel,IdTipoSaida, Codigo, Descricao, Significado, 
						MetodoCientificoObtencao, MetodoPraticoObtencao, PerguntaSistema, 
						InteligenciaSistemicaModelo, Comentario, DataCriacao, DataModificacao, ColunaImportacao,
						IdTipoDadoVariavel, IdUsuario)
		values(@IdTipoVariavel, @IdClasseVariavel, @IdTipoSaida, @Codigo, @Descricao, @Significado,
				@MetodoCientificoObtencao, @MetodoPraticoObtencao, @PerguntaSistema, 
				@InteligenciaSistemicaModelo, @Comentario, GETDATE(), GETDATE(), @ColunaImportacao, @IdTipoDadoVariavel, @IdUsuario);

	Select @IdVariavel = @@IDENTITY;

END

GO
/****** Object:  StoredProcedure [dbo].[VariavelOutputGlobalListar]    Script Date: 11/30/2009 17:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelOutputGlobalListar]
(
@IdModelo int,
@IdTipoSaida int,
@IdClasseVariavel int
)
AS
BEGIN

	select Variavel.* from Variavel 
		inner join ModeloVariavel 
			on Variavel.IdVariavel = ModeloVariavel.IdVariavel
		where ModeloVariavel.IdModelo = @IdModelo
		and variavel.IdTipoSaida = @IdTipoSaida
		and variavel.IdClasseVariavel = isnull(@IdClasseVariavel, variavel.IdClasseVariavel) ;

END

GO
/****** Object:  StoredProcedure [dbo].[VariavelRegraLogicaListar]    Script Date: 11/30/2009 17:02:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[VariavelRegraLogicaListar]
@IdVariavel int
as
begin
select VariavelRegraLogica.* from VariavelRegraLogica
inner Join RegraLogica on
RegraLogica.IdRegraLogica = VariavelRegraLogica.IdRegraLogica

where RegraLogica.IdVariavel = isnull(@IdVariavel, RegraLogica.IdVariavel);
end
GO
/****** Object:  StoredProcedure [dbo].[VariavelRegraLogicaNova]    Script Date: 11/30/2009 17:02:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelRegraLogicaNova]
@IdVariavel int output,
@IdRegraLogica int,
@IdCriterio int,
@Valor float
AS
BEGIN
	Insert into VariavelRegraLogica(IdVariavel, IdRegraLogica,IdCriterio, Valor)
		values(@IdVariavel, @IdRegraLogica, @IdCriterio, @Valor);
END

GO
/****** Object:  StoredProcedure [dbo].[VariavelRegraLogicaProcessoSegmentoListar]    Script Date: 11/30/2009 17:02:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelRegraLogicaProcessoSegmentoListar]
(
@IdClasseVariavel int,
@IdTipoSaida int,
@IdModelo int,
@IdRegraLogica int
)
AS
BEGIN

	select VRL.* from VariavelRegraLogica VRL
		inner join RegraLogica RL on VRL.IdRegraLogica = RL.IdRegraLogica
		inner join Variavel VR on VR.IdVariavel = RL.IdVariavel
		inner join ModeloVariavel MV on MV.IdVariavel = VR.IdVariavel
	where VR.IdClasseVariavel = isnull(@IdClasseVariavel, VR.IdClasseVariavel)
		and VR.IdTipoSaida = @IdTipoSaida
		and MV.IdModelo = @IdModelo
		and RL.IdRegraLogica = @IdRegraLogica
	order by VRL.IdRegraLogica asc, VRL.IdVariavel asc

END

GO
/****** Object:  StoredProcedure [dbo].[VariavelRegraLogicoRemover]    Script Date: 11/30/2009 17:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelRegraLogicoRemover]
@IdVariavel int,
@IdRegraLogica int
AS
BEGIN
	delete from VariavelRegraLogica
	where (Idvariavel = @IdVariavel and IdRegraLogica = @IdRegraLogica)
END

GO
/****** Object:  StoredProcedure [dbo].[VariavelRelacaoModeloListar]    Script Date: 11/30/2009 17:02:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelRelacaoModeloListar]
(
@IdModelo int
)
AS
BEGIN

	select Variavel.* from Variavel
		inner join ModeloVariavel on ModeloVariavel.IdVariavel = Variavel.IdVariavel
	where (ModeloVariavel.IdModelo = @IdModelo)

END

GO
/****** Object:  StoredProcedure [dbo].[VariavelRemover]    Script Date: 11/30/2009 17:02:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VariavelRemover]
@IdVariavel int
AS
BEGIN

	delete from Variavel
	Where IdVariavel = @IdVariavel;

END

GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorEditar]    Script Date: 11/30/2009 17:02:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoProdutoFatorEditar]
@IdVersaoProdutoFator int,
@Descricao Varchar(40),
@IdModelo int,
@IdUsuario int
as
BEGIN
	update VersaoProdutoFator
		set Descricao = isnull(@Descricao, Descricao),
			DataModificacao = Getdate(), 
			IdModelo = isnull(@IdModelo, IdModelo),
			IdUsuario = isnull(@IdUsuario, IdUsuario)
		where IdVersaoProdutoFator = @IdVersaoProdutoFator;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorListar]    Script Date: 11/30/2009 17:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoProdutoFatorListar]
@IdVersaoProdutoFator int,
@IdModelo int
as
BEGIN
	select * from  VersaoProdutoFator
	where IdVersaoProdutoFator = isnull(@IdVersaoProdutoFator, IdVersaoProdutoFator)
	and IdModelo = @IdModelo;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorListarPorModelo]    Script Date: 11/30/2009 17:02:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[VersaoProdutoFatorListarPorModelo]
(
	@IdModelo int
)
as
select * from VersaoProdutoFator where IdModelo = @IdModelo
GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorNovo]    Script Date: 11/30/2009 17:02:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoProdutoFatorNovo]
@IdVersaoProdutoFator int output,
@Descricao Varchar(40),
@IdModelo int,
@IdUsuario int
as
BEGIN
	insert into VersaoProdutoFator(Descricao,  DataCriacao,	DataModificacao, IdModelo, IdUsuario)
	values (@Descricao, Getdate(), Getdate(), @IdModelo, @IdUsuario);
	select @IdVersaoProdutoFator = @@Identity;
END
GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorProdutoNivelListar]    Script Date: 11/30/2009 17:03:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoProdutoFatorProdutoNivelListar]
(
@IdVersaoProdutoFator int
)
as
Begin

	Select VersaoProdutoFatorProdutoNivel.*, ProdutoNivel.Nome from dbo.VersaoProdutoFatorProdutoNivel
		inner join ProdutoNivel on VersaoProdutoFatorProdutoNivel.IdProdutoNivel = ProdutoNivel.IdProdutoNivel
		Where IdVersaoProdutoFator = @IdVersaoProdutoFator

End
GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorRemover]    Script Date: 11/30/2009 17:03:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoProdutoFatorRemover]
@IdVersaoProdutoFator int
as
BEGIN
	delete from  VersaoProdutoFator
	where IdVersaoProdutoFator = @IdVersaoProdutoFator;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoProdutoFatorSegmentoListar]    Script Date: 11/30/2009 17:03:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[VersaoProdutoFatorSegmentoListar]
(
@IdVersaoProdutoFator int
)
as
begin

	select Segmento.*, VersaoProdutoFatorSegmento.IdVersaoProdutoFator from Segmento
		inner join VersaoProdutoFatorSegmento 
			on VersaoProdutoFatorSegmento.IdSegmento = Segmento.IdSegmento
	where VersaoProdutoFatorSegmento.IdVersaoProdutoFator = @IdVersaoProdutoFator

end
GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoEditar]    Script Date: 11/30/2009 17:03:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoEditar]
@IdVersaoProdutoFator int,
@IdProduto int,
@IdSegmento int,
@IdFator int,
@IdCriterio int
as
BEGIN
	update VersaoSegmentoProdutoFatorProduto
		set IdCriterio = @IdCriterio
		where IdVersaoProdutoFator = @IdVersaoProdutoFator
		and IdProduto = @IdProduto
		and IdSegmento = @IdSegmento
		and IdFator = @IdFator;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoListar]    Script Date: 11/30/2009 17:03:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoListar]
@IdVersaoProdutoFator int,
@IdSegmento int
as
BEGIN
	select * from  VersaoSegmentoProdutoFatorProduto
	where (IdVersaoProdutoFator = isnull(@IdVersaoProdutoFator, IdVersaoProdutoFator) and
			IdSegmento = isnull(@IdSegmento, IdSegmento));
END
GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoNivelEditar]    Script Date: 11/30/2009 17:03:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoNivelEditar]
@IdVersaoProdutoFator int,
@IdProdutoNivel int,
@IdSegmento int,
@IdFator int,
@IdCriterio int
as
BEGIN
	update VersaoSegmentoProdutoFatorProdutoNivel
		set IdCriterio = @IdCriterio
		where IdVersaoProdutoFator = @IdVersaoProdutoFator
		and IdProdutoNivel = @IdProdutoNivel
		and IdSegmento = @IdSegmento
		and IdFator = @IdFator;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoNivelListar]    Script Date: 11/30/2009 17:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoNivelListar]
@IdVersaoProdutoFator int,
@IdSegmento int
as
BEGIN
	select * from  VersaoSegmentoProdutoFatorProdutoNivel
	where (IdVersaoProdutoFator = isnull(@IdVersaoProdutoFator, IdVersaoProdutoFator) and
			IdSegmento = isnull(@IdSegmento, IdSegmento));
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoNivelNovo]    Script Date: 11/30/2009 17:03:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoNivelNovo]
@IdVersaoProdutoFator int,
@IdProdutoNivel int,
@IdSegmento int,
@IdFator  int,
@IdCriterio  int

as
BEGIN
	insert 
	into VersaoSegmentoProdutoFatorProdutoNivel
			(IdVersaoProdutoFator, IdProdutoNivel, IdSegmento, IdFator, IdCriterio)
	values (@IdVersaoProdutoFator, @IdProdutoNivel, @IdSegmento, @IdFator, @IdCriterio);
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoNivelRemover]    Script Date: 11/30/2009 17:03:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoNivelRemover]
@IdVersaoProdutoFator int,
@IdProdutoNivel int,
@IdSegmento int,
@IdFator int
as
BEGIN
	delete from  VersaoSegmentoProdutoFatorProdutoNivel
	where IdVersaoProdutoFator = @IdVersaoProdutoFator
		and IdProdutoNivel = @IdProdutoNivel
		and IdSegmento = @IdSegmento
		and IdFator = @IdFator;
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoNovo]    Script Date: 11/30/2009 17:03:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoNovo]
@IdVersaoProdutoFator int,
@IdProduto int,
@IdSegmento int,
@IdFator  int,
@IdCriterio  int

as
BEGIN
	insert 
	into VersaoSegmentoProdutoFatorProduto
			(IdVersaoProdutoFator, IdProduto, IdSegmento, IdFator, IdCriterio)
	values (@IdVersaoProdutoFator, @IdProduto, @IdSegmento, @IdFator, @IdCriterio);
END

GO
/****** Object:  StoredProcedure [dbo].[VersaoSegmentoProdutoFatorProdutoRemover]    Script Date: 11/30/2009 17:03:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VersaoSegmentoProdutoFatorProdutoRemover]
@IdVersaoProdutoFator int,
@IdProduto int,
@IdSegmento int,
@IdFator int
as
BEGIN
	delete from  VersaoSegmentoProdutoFatorProduto
	where IdVersaoProdutoFator = @IdVersaoProdutoFator
		and IdProduto = @IdProduto
		and IdSegmento = @IdSegmento
		and IdFator = @IdFator;
END
