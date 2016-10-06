% Arthur Bridi Guazzelli
% 15100720

% -----Banco de dados----- %
	% ---Primeira Fase
	materia('EGR7105', 'Desenho de Observação', 1, 
		[]).
	materia('EGR7107', 'História da Arte', 1, 
		[]).
	materia('EGR7109', 'Teoria da Cor', 1, 
		[]).
	materia('EGR7110', 'Plástica', 1, 
		[]).
	materia('EGR7113', 'Semiótica', 1, 
		[]).
	materia('EGR7212', 'Animação e Cinema', 1, 
		[]).

	% ---Segunda Fase
	materia('EGR7108', 'Desenho Aplicado', 2, 
		[]).
	materia('EGR7116', 'Teoria da Forma', 2, 
		[]).
	materia('EGR7118', 'Design e Cultura', 2, 
		[]).
	materia('EGR7190', 'Ilustração Digital', 2, 
		[]).
	materia('EGR7192', 'Tratamento de Imagem I', 2, 
		[]).
	materia('EGR7411', 'Narrativa e Linguagem Visual', 2, 
		['EGR7113']).

	% ---Terceira Fase
	materia('EGR7421', 'Arte Conceitual', 3, 
		['EGR7190']).
	materia('EGR7422', 'Edição de Son', 3, 
		[]).
	materia('EGR7423', 'Edição e Composição de Vídeo', 3, 
		['EGR7192']).
	materia('EGR7424', 'Roteiro e Direção', 3, 
		['EGR7411']).
	materia('EGR7425', 'Projeto 1', 3, 
		['EGR7411']).

	% ---Quarta Fase
	materia('EGR7431', 'Design de Cenários', 4, 
		['EGR7421']).
	materia('EGR7432', 'Design de Personagens', 4, 
		['EGR7421']).
	materia('EGR7433', 'Desenho para Animação 2D', 4, 
		[]).
	materia('EGR7434', 'Princípios de Animação', 4, 
		[]).
	materia('EGR7435', 'Projeto 2', 4, 
		['EGR7425']).

	% ---Quinta Fase
	materia('EGR7441', 'Animação 3D', 5, 
		['EGR7434']).
	materia('EGR7442', 'Escultura Digital', 5, 
		[]).
	materia('EGR7443', 'Modelagem 3D', 5, 
		[]).
	materia('EGR7444', 'Rendering de Animação', 5, 
		[]).
	materia('EGR7445', 'Projeto 3', 5, 
		['EGR7435']).

	% ---Sexta Fase
	materia('EGR7451', 'Deontologia do Audiovisual', 6, 
		[]).
	materia('EGR7452', 'Gestão do Design', 6, 
		[]).
	materia('EGR7455', 'Estágio Curricular Obrigatório', 6, 
		['EGR7445']).

	% ---Sétima Fase
	materia('EGR7465', 'Projeto 4', 7, 
		['EGR7455']).

% -----Funções----- %
	fase(Codigo, Fase) :- materia(Codigo, X, Fase, Y).

	prereq(Codigo, Requisitos) :- materia(Codigo, X, Y, Requisitos).
	
	nome(Codigo, Nome, Fase) :- materia(Codigo, Nome, Fase, Y).