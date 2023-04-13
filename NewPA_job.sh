#!/bin/bash
#SBATCH --job-name=zero
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --exclusive
#SBATCH --time=00:20:00
#SBATCH --account=rrg-ssanner
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --mail-user=<armin.toroghi@mail.utoronto.ca>
#SBATCH --mail-type=ALL

#wandb offline
#wandb online -num_run 
#wandb agent atoroghi/pre-critiquing/xydr8uhv
#python3 launch.py -epochs 1 -save_each 1 -kg no_kg
source ~/projects/def-ssanner/atoroghi/project/ENV2/bin/activate
cd ~/projects/def-ssanner/atoroghi/project/cqd
#python3 nested_cv_zero.py -tune_name soft_best -reg_type gauss -loss_type softplus -reduce_type sum -optim_type adagrad -sample_type split_rev -init_type uniform -kg kg 
#python3 nested_cv_zero.py -tune_name svd_neg_soft -reg_type gauss -loss_type softplus -reduce_type sum -optim_type adagrad -sample_type split_reg -init_type uniform -learning_rel freeze -kg no_kg 
#python3 inner_cv.py -tune_name gaussindirect -fold 0
#python3 -m kbc.cqd_beam --model_path models/NELL-model-rank-1000-epoch-100-*.pt --dataset ${DATA} --mode valid --t_norm ${T_NORM} --candidates ${CANDIDATE} --scores_normalize 0 data/NELL
#python3 -m kbc.cqd_co --model_path models/NELL-model-rank-1000-epoch-100-*.pt --dataset ${DATA} --mode valid --t_norm ${T_NORM} --chain_type ${CHAIN_TYPE} data/NELL
#python3 -m kbc.learn data/${DATA} --rank ${RANK} --reg ${REG} --max_epochs 300 --batch_size ${BATCH_SIZE} --model SimplE
#python3 -m kbc.out
#python -m kbc.cqd_co --model_path models/NELL-SimplE-model-rank-1000-epoch-300-1679308235.pt --dataset NELL --mode test --t_norm prod data/NELL --chain_type 2_2_disj
#python3 -m kbc.bpl_co --model_path models/FB15k-237-SimplE-model-rank-2000-epoch-300-1681026474.pt --dataset ${DATASET} --mode valid --t_norm prod data/FB15k-237 --chain_type ${CHAIN_TYPE} --cov_anchor ${COV_ANCHOR} --cov_var ${COV_VAR} --cov_target ${COV_TARGET}
python3 -m kbc.slurm_processor
