import os
from operator import itemgetter
from langchain_community.utilities import SQLDatabase
from langchain.chains import create_sql_query_chain
from langchain_community.tools.sql_database.tool import QuerySQLDataBaseTool
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import ChatOpenAI
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

# Configuração da chave da API da OpenAI
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")
if not os.environ["OPENAI_API_KEY"]:
    raise ValueError("A chave da OpenAI não foi definida nas variáveis de ambiente.")

# Configuração do banco de dados
db = SQLDatabase.from_uri("mysql+mysqlconnector://root:root@localhost/db")

# Inicializando o modelo
llm = ChatOpenAI(model="gpt-4o-mini")

# Criando a cadeia para gerar consultas SQL
write_query = create_sql_query_chain(llm, db)

# Criando a ferramenta para executar as consultas SQL
execute_query = QuerySQLDataBaseTool(db=db)

# Template para responder a pergunta com base na consulta SQL e resultado
answer_prompt = PromptTemplate.from_template(
    """Dada a seguinte pergunta do usuário, a consulta SQL correspondente e o resultado da SQL, responda a pergunta do usuário.
    caso tenha um erro, repita exatamente a consulta e o resultado que você recebeu abaixo:
    Pergunta: {question}
    Consulta SQL: {query}
    Resultado SQL: {result}
    Resposta: """
)

# Combinando os elementos em uma única cadeia
chain = (
    RunnablePassthrough.assign(query=write_query).assign(
        result=lambda inputs: execute_query.invoke(inputs['query']
            .replace("SQLQuery: ", "")
            .replace("```sql", "")
            .replace("```", "")
            .strip())
    )
    | answer_prompt
    | llm
    | StrOutputParser()
)

# Invocando a cadeia com uma pergunta
response = chain.invoke({"question": "Qual foi a última vez que comprei arroz e qual era o preço?"})
# response = chain.invoke({"question": "eu comprei arroz hoje por 7 reais, adicione pra mim."})

# Imprimir a consulta SQL gerada e a resposta final
print("Resposta da cadeia:")
print(response)  # Imprime toda a resposta para depuração
