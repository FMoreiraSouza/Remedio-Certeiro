import 'package:appwrite/appwrite.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppWriteService {
  final Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // URL do Appwrite
      .setProject('67906537001a621d1f53'); // ID do projeto

  late final GraphQLClient graphqlClient;

  AppWriteService() {
    // Configurar HttpLink com os cabeçalhos necessários
    final HttpLink httpLink = HttpLink(
      'https://cloud.appwrite.io/v1/graphql',
      defaultHeaders: {
        'Content-Type': 'application/json',
        'X-Appwrite-Project': '67906537001a621d1f53', // ID do projeto
        'X-Appwrite-Key':
            'standard_c48872597b14aa48904ea14d698e22a61af739c0484d2049b93bf8be226d1403d72f046a4956b3490880da5a61060a0c69868cbaac37ecfd5a183a5cb3b16147659038c0f037c509a938a6fe97a36f81993c62d803b51d54177079afcf3a5b59640dc206cb4c59968bba7a7a89c1cca4c4c2835c5e5ce8a16e378f6721ed99f6', // API Key
      },
    );

    graphqlClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  Future<Map<String, dynamic>> createUser({
    required String email,
    required String password,
    String? name,
  }) async {
    const String mutation = r'''
    mutation CreateUser($email: String!, $password: String!, $name: String!) {
      accountCreate(
        userId: "unique()",
        email: $email,
        password: $password,
        name: $name
      ) {
        _id
        _createdAt
        _updatedAt
        name
        email
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'email': email,
        'password': password,
        'name': name ?? '',
      },
    );

    final QueryResult result = await graphqlClient.mutate(options);

    if (result.hasException) {
      print("Erro na mutation GraphQL: ${result.exception.toString()}");
      throw Exception(result.exception.toString());
    }

    return result.data?['accountCreate'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createUserDocument({
    required int cpf,
    required int age,
    required int phone,
    required String userId,
  }) async {
    const String mutation = r'''
    mutation CreateUserDocument($cpf: Int!, $age: Int!, $phone: Int!, $userId: String!) {
      databasesCreateDocument(
        databaseId: "67944210001fd099f8bc",  
        collectionId: "6794439e000f4d482ae3",
        documentId: $userId,  
        data: {
          cpf: $cpf,
          age: $age,
          phone: $phone
        },
        permissions: ["read('any')"]
      ) {
        _id
        _collectionId
        _databaseId
        _createdAt
        _updatedAt
        _permissions
        data
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'cpf': cpf,
        'age': age,
        'phone': phone,
        'userId': userId,
      },
    );

    final QueryResult result = await graphqlClient.mutate(options);

    if (result.hasException) {
      print("Erro na mutation GraphQL: ${result.exception.toString()}");
      throw Exception(result.exception.toString());
    }

    return result.data?['databasesCreateDocument'] as Map<String, dynamic>;
  }
}
