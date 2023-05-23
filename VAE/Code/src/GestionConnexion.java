import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Button;


public class GestionConnexion implements EventHandler<ActionEvent>{
    private Connexion appli;
    
    public GestionConnexion(Connexion appli){
        this.appli = appli;
    }
    
    public void handle(ActionEvent e){
        Button button = (Button) (e.getSource());
        boolean inboucle = false;
        if(button.getText().contains("Inscrivez")){
            this.appli.inscription();
            inboucle = true;
        }
        if(!inboucle){
            this.appli.connection();
        }
        
    }
}