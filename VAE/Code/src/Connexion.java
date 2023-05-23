import javafx.scene.Scene;
import javafx.scene.chart.PieChart;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.ContentDisplay;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.layout.Border;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.Priority;
import javafx.scene.layout.TilePane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Screen;
import javafx.stage.Stage;
import javafx.stage.Window;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.geometry.Rectangle2D;
import javafx.geometry.Side;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;


public class Connexion extends Application{
    private TextField tf1;
    private PasswordField tf2;
    private TextField tf3;
    private GridPane mainPane;
    private Stage stage;
    private static final double BUTTON_HEIGHT = 150;

    public Connexion(){
        super();
        this.tf1 = new TextField();
        this.tf2 = new PasswordField();
        this.tf3 = new TextField();
    }

    @Override
    public void init(){}

    @Override
    public void start(Stage stage){
        GridPane root = new GridPane();
        BackgroundImage backGround = new BackgroundImage(new Image("file:img/BackgroundWithLogo.png",400,650,false,true), null, null, null, null);
        root.setBackground(new Background(backGround));

        //Ajout des bouttons
        Button user = new Button();
        ImageView view = new ImageView(new Image("file:img/User.png"));
        view.setFitHeight(BUTTON_HEIGHT);
        view.setPreserveRatio(true);
        user.setGraphic(view);
        user.setContentDisplay(ContentDisplay.TOP);
        user.setOnAction(new GestionConnexion(this));
        user.setStyle(
                "-fx-background-color: transparent;" +
                "-fx-border-width: 5em;" +
                "-fx-border-radius:50%;"
        );
        VBox box = new VBox();
        Button connexion = new Button("Démarrer!");
        connexion.setOnAction(new GestionConnexion(this));
        box.getChildren().add(connexion);
        box.setAlignment(Pos.CENTER);
        //Ajout des éléments à root
        root.add(user,0,0);
        root.add(box,0,1);
        root.setAlignment(Pos.CENTER);
        //Ajout de la GridPane dans l'attribut mainPane
        this.mainPane = root;
        this.stage = stage;

        //Affichage de la fenêtre
        this.afficherFenetre();
    }

    public void connection(){
        GridPane root = new GridPane();
        BackgroundImage backGround = new BackgroundImage(new Image("file:img/BackgroundWithLogo.png",400,650,false,true), null, null, null, null);
        root.setBackground(new Background(backGround));
        //Création de la boite principale
        VBox mainBox = new VBox();
        BackgroundImage backGround2 = new BackgroundImage(new Image("file:img/Background2.png",254,311,false,true), null, null, null, null);
        mainBox.setBackground(new Background(backGround2));
        mainBox.setPrefWidth(254);
        mainBox.setPrefHeight(311);
        Label username = new Label("Nom d'utilisateur");
        username.setFont(Font.font("Arial",FontWeight.BOLD,18));
        username.setTextFill(Color.web("#ffffff"));
        VBox.setMargin(username, new Insets(120, 40, 5, 10));
        TextField tF = new TextField();
        VBox.setMargin(tF, new Insets(0, 40, 10, 10));
        Label password = new Label("Mot de passe");
        password.setFont(Font.font("Arial",FontWeight.BOLD,18));
        password.setTextFill(Color.web("#ffffff"));
        VBox.setMargin(password, new Insets(0, 40, 5, 10));
        PasswordField pwF = new PasswordField();
        VBox.setMargin(pwF, new Insets(0, 40, 10, 10));
        //Création de la boite des boutons
        HBox box = new HBox();
        Button connexion = new Button("Connexion");
        connexion.setOnAction(new GestionConnexion(this));
        HBox.setMargin(connexion, new Insets(1));
        Button inscription = new Button("Inscrivez-vous!");
        inscription.setOnAction(new GestionConnexion(this));
        HBox.setMargin(inscription, new Insets(1));
        box.getChildren().addAll(connexion,inscription);
        VBox.setMargin(box, new Insets(0, 35, 10, 10));
        mainBox.getChildren().addAll(username,tF,password,pwF,box);
        

        //Ajout des éléments à root
        root.add(mainBox,0,0);
        root.setAlignment(Pos.CENTER);

        //Ajout de la GridPane dans l'attribut mainPane
        this.mainPane = root;

        //Affichage de la fenêtre
        this.afficherFenetre();
    }

    public void inscription(){
        GridPane root = new GridPane();
        BackgroundImage backGround = new BackgroundImage(new Image("file:img/BackgroundWithLogo.png",400,650,false,true), null, null, null, null);
        root.setBackground(new Background(backGround));

        VBox mainBox = new VBox();
        BackgroundImage backGround2 = new BackgroundImage(new Image("file:img/BgInscription.png",254,400,false,true), null, null, null, null);
        mainBox.setBackground(new Background(backGround2));
        mainBox.setPrefWidth(254);
        mainBox.setPrefHeight(400);
        //Username
        Label username = new Label("Nom d'utilisateur");
        username.setFont(Font.font("Arial",FontWeight.BOLD,18));
        username.setTextFill(Color.web("#ffffff"));
        VBox.setMargin(username, new Insets(120, 40, 5, 10));
        TextField tF = new TextField();
        VBox.setMargin(tF, new Insets(0, 40, 10, 10));
        //PassWord
        Label password = new Label("Mot de passe");
        password.setFont(Font.font("Arial",FontWeight.BOLD,18));
        password.setTextFill(Color.web("#ffffff"));
        VBox.setMargin(password, new Insets(0, 40, 5, 10));
        PasswordField pwF = new PasswordField();
        VBox.setMargin(pwF, new Insets(0, 40, 10, 10));
        //Mail
        Label mail = new Label("Adresse Mail");
        mail.setFont(Font.font("Arial",FontWeight.BOLD,18));
        mail.setTextFill(Color.web("#ffffff"));
        VBox.setMargin(mail, new Insets(0, 40, 5, 10));
        TextField tfMail = new TextField();
        VBox.setMargin(tfMail, new Insets(0, 40, 10, 10));
        //Button
        Button inscription = new Button("Inscription");
        inscription.setOnAction(new GestionConnexion(this));
        VBox.setMargin(inscription, new Insets(0, 40, 10, 10));
        //Lower
        Label text = new Label("Vous avez déjà un compte ?");
        text.setTextFill(Color.web("#ffffff"));
        text.setFont(Font.font("Arial",FontWeight.BOLD,12));
        VBox.setMargin(text, new Insets(0, 40, 2, 10));
        Button connexion = new Button("Connectez-vous!");
        connexion.setOnAction(new GestionConnexion(this));
        VBox.setMargin(connexion, new Insets(0, 40, 10, 10));
        mainBox.getChildren().addAll(username,tF,password,pwF,mail,tfMail,inscription,text,connexion);        
        //Ajout des éléments à root
        root.add(mainBox,0,0);
        root.setAlignment(Pos.CENTER);

        //Ajout de la GridPane dans l'attribut mainPane
        this.mainPane = root;

        //Affichage de la fenêtre
        this.afficherFenetre();
    }

    public void afficherFenetre(){
        //Affichage de la fenêtre
        Scene scene = new Scene(this.mainPane,400,650);
        this.stage.setScene(scene);
        this.stage.setTitle("Fenêtre de connexion");
        this.stage.show();
        this.stage.setResizable(false);
    }

    public static void main(String[] args) {
        launch(Connexion.class, args);
    }
}