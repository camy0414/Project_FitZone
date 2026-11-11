package co.edu.unbosque.backFitZone.configuration;
 
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
 
@Configuration
public class MongoDBConfig {
 
	@Bean
	public MongoDatabase mongoDatabase(MongoClient mongoClient, @Value("${fitzone.mongodb.database}") String nombre) {
		return mongoClient.getDatabase(nombre);
	}
}